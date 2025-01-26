return {
  'numToStr/Comment.nvim',
  enabled = true,
  keys = {
    { '<leader>cc', '<Plug>(comment_toggle_linewise)', mode = { 'v' }, desc = 'Comment: Toggle linewise' },
    { '<leader>cb', '<Plug>(comment_toggle_blockwise)', mode = { 'v' }, desc = 'Comment: Toggle blockwise' },
    {
      '<leader>cc',
      '<Plug>(comment_toggle_linewise_current)',
      mode = { 'n' },
      desc = 'Comment: Toggle linewise current',
    },
    {
      '<leader>cb',
      '<Plug>(comment_toggle_blockwise_current)',
      mode = { 'n' },
      desc = 'Comment: Toggle blockwise current',
    },
  },
  opts = {
    padding = true,
    sticky = true,
    ignore = '^$',
    toggler = {
      line = '<leader>cc',
      block = '<leader>bc',
    },
    opleader = {
      line = '<leader>cc',
      block = '<leader>bc',
    },
    mappings = {
      basic = true,
      extra = false,
    },
  },
}
