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
