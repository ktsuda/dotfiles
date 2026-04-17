vim.g.table_mode_corner = '|'
vim.g.table_mode_delimiter = '\t'

vim.keymap.set('n', '<leader>mt', ':TableModeToggle<cr>', { desc = 'Toggle markdown table mode' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>mc', ':Tableize<cr>', { desc = 'Tableize' })
