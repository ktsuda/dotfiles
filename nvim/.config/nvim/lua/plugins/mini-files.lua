return {
  'nvim-mini/mini.files',
  enabble = false,
  version = false,
  keys = {
    {
      '<C-e>',
      function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0))
      end,
      desc = 'Open filer',
    },
  },
  opts = {
    mappings = {
      close = '<C-e>',
      go_in = 'l',
      go_in_plus = 'L',
      go_out = 'h',
      go_out_plus = 'H',
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = '=',
      trim_left = '<',
      trim_right = '>',
    },
  },
}
