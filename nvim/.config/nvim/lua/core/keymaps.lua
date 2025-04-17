vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- nowait
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true, desc = 'Motion: Move up' })
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true, desc = 'Motion: Move down' })
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { desc = 'Quickfix: Previous quickfix' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Quickfix: Next quickfix' })
vim.keymap.set('n', '<C-h>', '<cmd>bprev<cr>', { desc = 'Buffer: Previous buffer' })
vim.keymap.set('n', '<C-l>', '<cmd>bnext<cr>', { desc = 'Buffer: Next buffer' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostic: Open diagnostic float' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({
    count = -1,
  })
end, { desc = 'Diagnostic: Previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({
    count = 1,
  })
end, { desc = 'Diagnostic: Next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic: Set loclist' })
vim.keymap.set('n', '<leader>xx', '<cmd>so %<cr>', { desc = 'Execute the current file' })
