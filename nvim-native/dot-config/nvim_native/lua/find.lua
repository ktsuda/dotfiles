-- `vim.fn.termopen()` is deprecated since nvim 0.11; keep a shim so the config
-- still loads on older versions instead of hard-failing on an unknown option.
local function open_term(cmd, opts)
	if vim.fn.has("nvim-0.11") == 1 then
		opts = vim.tbl_extend("force", opts or {}, { term = true })
		return vim.fn.jobstart(cmd, opts)
	end
	return vim.fn.termopen(cmd, opts)
end

local function fast_fzf_find()
	if vim.fn.executable("fd") == 0 or vim.fn.executable("fzf") == 0 then
		vim.notify("fast_fzf_find: `fd` and `fzf` are required", vim.log.levels.ERROR)
		return
	end

	local search_cmd = "fd --type f --hidden --exclude .git | fzf"

	-- `columns`/`lines` stay correct with no UI attached and with multiple UIs,
	-- unlike nvim_list_uis()[1].
	local total_w, total_h = vim.o.columns, vim.o.lines
	local win_width = math.floor(total_w * 0.9)
	local win_height = math.floor(total_h * 0.8)

	local bufnr = vim.api.nvim_create_buf(false, true)
	local win_id = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = math.floor((total_h - win_height) / 2),
		col = math.floor((total_w - win_width) / 2),
		border = "single",
		title = " Fuzzy Finder ",
		title_pos = "center",
	})

	local output_file = vim.fn.tempname()

	local function cleanup()
		if vim.api.nvim_win_is_valid(win_id) then
			vim.api.nvim_win_close(win_id, true)
		end
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
		os.remove(output_file)
	end

	local job_id = open_term(string.format("%s > %s", search_cmd, vim.fn.shellescape(output_file)), {
		on_exit = function(_, exit_code)
			-- Defer: destroying the terminal buffer from inside its own exit
			-- callback races with nvim's own teardown of the channel.
			vim.schedule(function()
				local selected
				if exit_code == 0 then
					local f = io.open(output_file, "r")
					if f then
						selected = f:read("*l")
						f:close()
					end
				end
				-- Close the float first so :edit lands in the previous window.
				cleanup()
				if selected and selected ~= "" then
					vim.cmd.edit(vim.fn.fnameescape(selected))
				end
			end)
		end,
	})

	-- jobstart() returns 0 (invalid args) or -1 (cmd not executable) on failure;
	-- without this the float and the temp file leak.
	if job_id <= 0 then
		cleanup()
		vim.notify("fast_fzf_find: failed to start job", vim.log.levels.ERROR)
		return
	end

	vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("FastFind", fast_fzf_find, {})
vim.keymap.set("n", "<C-p>", "<cmd>FastFind<cr>", { silent = true })
