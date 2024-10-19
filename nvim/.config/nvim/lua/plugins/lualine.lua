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
      icons_enabled = true,
    },
    extensions = {
      'quickfix',
      'fugitive',
      'neo-tree',
      'fzf',
      'lazy',
    },
  },
}
