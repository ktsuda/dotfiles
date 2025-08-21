return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = 'solarized_dark',
      icons_enabled = true,
    },
    extensions = {
      'quickfix',
      'fugitive',
      'neo-tree',
      'oil',
      'fzf',
      'lazy',
    },
  },
}

