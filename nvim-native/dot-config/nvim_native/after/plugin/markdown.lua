vim.g.table_mode_corner = "|"
vim.g.table_mode_delimiter = "\t"

vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0

vim.keymap.set({ "n" }, "<leader>mt", ":TableModeToggle<cr>")
vim.keymap.set({ "n", "v", "x" }, "<leader>mc", ":Tableize<cr>")
vim.keymap.set({ "n" }, "<leader>mp", ":MarkdownPreviewToggle<cr>")
