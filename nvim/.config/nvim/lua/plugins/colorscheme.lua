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
    'arcticicestudio/nord-vim',
    config = function()
      vim.cmd.colorscheme('nord')
    end,
  },
}
