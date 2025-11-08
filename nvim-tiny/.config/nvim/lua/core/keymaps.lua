vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- nowait
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true, desc = 'Motion: Move up' })
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true, desc = 'Motion: Move down' })
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix' })
vim.keymap.set('n', '<C-h>', '<cmd>bprev<cr>', { desc = 'Buffer: Previous buffer' })
vim.keymap.set('n', '<C-l>', '<cmd>bnext<cr>', { desc = 'Buffer: Next buffer' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({
    count = -1,
  })
end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({
    count = 1,
  })
end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Set diagnostics qf' })
