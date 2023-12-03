return {
  {
    'xiyaowong/transparent.nvim',
    opts = function(_, opts)
      return vim.tbl_extend('force', {
        extra_groups = {
          'NormalFloat',
          'FloatBorder',
          'FloatTitle',
          'Pmenu',
          'WinSeparator',
        },
      }, opts or {})
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('onedark')
    end,
  },
}
