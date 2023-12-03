return {
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'kyazdani42/nvim-web-devicons' },
    },
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'kyazdani42/nvim-web-devicons' },
    },
    opts = {
      options = {
        theme = 'onedark',
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
  },
  {
    'nvchad/nvim-colorizer.lua',
    opts = {},
  },
}
