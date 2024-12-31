return {
  'numToStr/Comment.nvim',
  enabled = true,
  keys = {
    { '<leader>cc', '<Plug>(comment_toggle_linewise)', mode = { 'v' }, desc = '[c]omment [c]urrent line' },
    { '<leader>cb', '<Plug>(comment_toggle_blockwise)', mode = { 'v' }, desc = '[c]omment [b]lockwise' },
    { '<leader>cc', '<Plug>(comment_toggle_linewise_current)', mode = { 'n' }, desc = '[c]omment [c]urrent line' },
    { '<leader>cb', '<Plug>(comment_toggle_blockwise_current)', mode = { 'n' }, desc = '[c]omment [b]lockwise' },
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
