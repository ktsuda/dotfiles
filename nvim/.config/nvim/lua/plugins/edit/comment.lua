vim.pack.add({
  { src = 'https://github.com/numToStr/Comment.nvim' },
})

require('Comment').setup({
  padding = true,
  sticky = true,
  ignore = '^$',
  toggler = {
    line = '<leader>cc',
    block = '<leader>cb',
  },
  opleader = {
    line = '<leader>cc',
    block = '<leader>cb',
  },
  mappings = {
    basic = true,
    extra = false,
  },
})

vim.keymap.set('n', '<leader>cc', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment linewise' })
vim.keymap.set('x', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment linewise' })
vim.keymap.set('n', '<leader>cb', '<Plug>(comment_toggle_blockwise_current)', { desc = 'Toggle comment blockwise' })
vim.keymap.set('x', '<leader>cb', '<Plug>(comment_toggle_blockwise_visual)', { desc = 'Toggle comment blockwise' })
