vim.g.mapleader = ' '

-- explorer
vim.keymap.set('n', '<C-e>', vim.cmd.Ex)

-- playground
vim.keymap.set('n', '<leader>i', vim.cmd.InspectTree)

-- quicklist
vim.keymap.set('n', '[q', vim.cmd.cprevious, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

-- buffer
vim.keymap.set('n', '<C-h>', vim.cmd.bprev, { desc = 'Buffer: Previous buffer' })
vim.keymap.set('n', '<C-l>', vim.cmd.bnext, { desc = 'Buffer: Next buffer' })
vim.keymap.set('n', '<C-k>', vim.cmd.only, { desc = 'Buffer: Only this buffer' })
