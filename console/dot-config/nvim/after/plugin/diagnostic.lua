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
