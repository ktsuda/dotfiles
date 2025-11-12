vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- nowait
vim.keymap.set('n', '[q', vim.cmd.cprevious, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })
vim.keymap.set('n', '<C-h>', vim.cmd.bprev, { desc = 'Buffer: Previous buffer' })
vim.keymap.set('n', '<C-l>', vim.cmd.bnext, { desc = 'Buffer: Next buffer' })
vim.keymap.set('n', '<leader>pu', vim.pack.update, { desc = 'Update all plugins' })
