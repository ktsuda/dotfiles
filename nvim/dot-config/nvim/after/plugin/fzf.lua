local ok, fzf_lua = pcall(require, "fzf-lua")

if not ok then
	return
end

vim.keymap.set("n", "<C-p>", fzf_lua.files)
vim.keymap.set("n", "<leader>gs", fzf_lua.git_status)
vim.keymap.set("n", "<leader>sa", fzf_lua.grep_project)
vim.keymap.set("n", "<leader>sb", fzf_lua.buffers)
