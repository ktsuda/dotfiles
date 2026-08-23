local ok, fzf_float = pcall(require, "util.fzf_float")
if not ok then
	return
end

vim.api.nvim_create_user_command("FastFind", function()
	fzf_float.run({
		required = { "fd", "fzf" },
		title = " Fuzzy Finder ",
		cmd = function(outfile)
			return ("fd --type f --hidden --exclude .git | fzf > %s"):format(vim.fn.shellescape(outfile))
		end,
		on_select = function(lines)
			vim.cmd.edit(vim.fn.fnameescape(fzf_float.strip_ansi(lines[1])))
		end,
	})
end, {})

vim.keymap.set("n", "<C-p>", "<cmd>FastFind<cr>", { silent = true })
