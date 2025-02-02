return {
  'rebelot/kanagawa.nvim',
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
    theme = 'dragon',
    background = {
      dark = 'dragon',
      light = 'lotus',
    },
  },
  config = function(_, opts)
    vim.opt.background = 'dark'
    require('kanagawa').setup(opts)
    vim.cmd.colorscheme('kanagawa')
  end,
}

