vim.pack.add({
	{ src = "https://github.com/dhruvasagar/vim-table-mode" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
}, {
	load = true,
})

vim.cmd("silent TableModeEnable")
vim.fn["mkdp#util#install"]()
