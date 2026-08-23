local fzf_float = require("util.fzf_float")

--- Parse `git worktree list --porcelain`. This is the only machine-readable
--- worktree listing Git commits to; `wt list` is a human-facing table whose
--- columns collapse with terminal width.
local function git_worktrees(root)
	local out = vim.fn.systemlist({ "git", "-C", root, "worktree", "list", "--porcelain" })
	if vim.v.shell_error ~= 0 then
		return nil, table.concat(out, "\n")
	end

	local list, cur = {}, nil
	local function flush()
		-- The bare repository is registered as a worktree but has no checkout,
		-- which is exactly the entry we must not offer.
		if cur and cur.path and not cur.bare then
			table.insert(list, cur)
		end
		cur = nil
	end

	for _, line in ipairs(out) do
		if line == "" then
			flush()
		else
			local key, val = line:match("^(%S+)%s*(.*)$")
			if key == "worktree" then
				flush()
				cur = { path = val }
			elseif cur then
				if key == "bare" then
					cur.bare = true
				elseif key == "branch" then
					cur.branch = val:gsub("^refs/heads/", "")
				elseif key == "detached" then
					cur.detached = true
				elseif key == "HEAD" then
					cur.head = val:sub(1, 8)
				elseif key == "prunable" then
					cur.prunable = true
				elseif key == "locked" then
					cur.locked = true
				end
			end
		end
	end
	flush()
	return list
end

local function label_of(wt)
	local s = wt.branch or ("(detached " .. (wt.head or "?") .. ")")
	if wt.locked then
		s = s .. " [locked]"
	end
	if wt.prunable then
		s = s .. " [prunable]"
	end
	return s
end

local function do_lcd(win, path)
	if vim.fn.isdirectory(path) == 0 then
		vim.notify("FastRepo: not a directory: " .. path, vim.log.levels.ERROR)
		return
	end
	if not vim.api.nvim_win_is_valid(win) then
		win = vim.api.nvim_get_current_win()
	end
	-- `:lcd` is window-scoped and has no API equivalent: nvim_set_current_dir()
	-- is global, and vim.fn.chdir() infers its scope from the current window.
	local ok, err = pcall(vim.api.nvim_win_call, win, function()
		vim.cmd.lcd(vim.fn.fnameescape(path))
	end)
	if not ok then
		vim.notify("FastRepo: lcd failed: " .. tostring(err), vim.log.levels.ERROR)
		return
	end
	vim.notify("lcd " .. vim.fn.fnamemodify(path, ":~"))
end

--- Stage 2: pick a worktree inside the selected repository.
local function pick_worktree(root, origin_win)
	local list, err = git_worktrees(root)
	if not list then
		vim.notify("FastRepo: " .. (err or "git failed"), vim.log.levels.ERROR)
		return
	end
	if #list == 0 then
		vim.notify("FastRepo: no checked-out worktree under " .. root, vim.log.levels.WARN)
		return
	end
	if #list == 1 then
		-- A plain (non-bare) repo has exactly one worktree; a second picker
		-- with one candidate is pure friction.
		do_lcd(origin_win, list[1].path)
		return
	end

	local width = 0
	for _, wt in ipairs(list) do
		width = math.max(width, vim.fn.strdisplaywidth(label_of(wt)))
	end

	local lines = {}
	for _, wt in ipairs(list) do
		local label = label_of(wt)
		local pad = string.rep(" ", width - vim.fn.strdisplaywidth(label))
		-- TAB separates the two fields. Git refnames forbid ASCII control
		-- characters, so the branch label can never contain one -- the split is
		-- unambiguous even for paths that do.
		table.insert(lines, label .. pad .. "\t" .. wt.path)
	end

	local input = vim.fn.tempname()
	vim.fn.writefile(lines, input)

	fzf_float.run({
		required = { "fzf" },
		title = " worktree: " .. vim.fn.fnamemodify(root, ":t") .. " ",
		temps = { input },
		cmd = function(outfile)
			return table.concat({
				"cat " .. vim.fn.shellescape(input) .. " | fzf",
				"--prompt 'worktree> '",
				"--delimiter='\\t' --with-nth=1,2",
				-- Own the column alignment: with the default tabstop the padding
				-- above would be re-expanded and the columns would drift.
				"--tabstop=1",
				'--preview "git -C {2} log --oneline -n 15 2>/dev/null; echo; git -C {2} status --short 2>/dev/null"',
				"--preview-window 'right,55%,border-left'",
				"> " .. vim.fn.shellescape(outfile),
			}, " ")
		end,
		on_select = function(sel)
			local path = fzf_float.strip_ansi(sel[1]):match("^[^\t]*\t(.*)$")
			if not path then
				vim.notify("FastRepo: could not parse selection", vim.log.levels.ERROR)
				return
			end
			do_lcd(origin_win, path)
		end,
	})
end

--- Stage 1: pick a repository root from ghq.
local function fast_repo_lcd()
	-- Captured before any float steals focus: `:lcd` is window-scoped, so which
	-- window we run it in *is* the result. Everywhere else we could rely on
	-- nvim restoring the previous window after nvim_win_close; not here.
	local origin_win = vim.api.nvim_get_current_win()

	fzf_float.run({
		required = { "ghq", "fzf" },
		title = " ghq repositories ",
		cmd = function(outfile)
			return table.concat({
				"ghq list --full-path | fzf",
				"--prompt 'repo> '",
				-- Paths share long prefixes; rank tail matches (owner/repo)
				-- above matches in the host or root component.
				"--tiebreak=end",
				'--preview "git -C {} worktree list 2>/dev/null || ls -la {}"',
				"--preview-window 'right,55%,border-left'",
				"> " .. vim.fn.shellescape(outfile),
			}, " ")
		end,
		on_select = function(sel)
			local root = vim.fn.fnamemodify(fzf_float.strip_ansi(sel[1]), ":p"):gsub("/$", "")
			-- Deferred: the first float's terminal buffer is torn down in this
			-- same tick; opening the next terminal after it settles.
			vim.schedule(function()
				pick_worktree(root, origin_win)
			end)
		end,
	})
end

vim.api.nvim_create_user_command("FastRepo", fast_repo_lcd, {})
vim.keymap.set("n", "<C-s>", "<cmd>FastRepo<cr>", { silent = true, desc = "ghq + worktree -> :lcd" })
