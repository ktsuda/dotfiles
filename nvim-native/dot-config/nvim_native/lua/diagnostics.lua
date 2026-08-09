vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
})

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { silent = true })
