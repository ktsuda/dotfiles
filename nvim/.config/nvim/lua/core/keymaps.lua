vim.keymap.set({ 'n', 'v', 'x' }, '<Space>', '<Nop>', { silent = true }) -- nowait
vim.keymap.set('n', '[q', vim.cmd.cprevious, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })
vim.keymap.set('n', '<C-h>', vim.cmd.bprev, { desc = 'Buffer: Previous buffer' })
vim.keymap.set('n', '<C-l>', vim.cmd.bnext, { desc = 'Buffer: Next buffer' })
vim.keymap.set('n', '<leader>pu', vim.pack.update, { desc = 'Update all plugins' })

-- terminal
vim.keymap.set('n', '<leader>tt', '<cmd>split term://zsh<cr>', { desc = 'Open terminal' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Escape from term' })
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, { pattern = 'term://*', command = 'startinsert' })
