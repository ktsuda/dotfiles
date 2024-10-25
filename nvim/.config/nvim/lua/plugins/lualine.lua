return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = 'tokyonight',
      icons_enabled = false,
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
