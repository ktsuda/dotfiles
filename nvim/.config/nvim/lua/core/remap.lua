vim.g.mapleader = ' '

-- playground
vim.keymap.set('n', '<leader>i', vim.cmd.InspectTree)

-- quicklist
vim.keymap.set('n', '[q', vim.cmd.cprevious, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })
