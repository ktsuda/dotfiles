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
  },
  {
    'nvchad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      user_default_options = {
        names = false,
        mode = 'background',
        tailwind = true,
        always_update = false,
      },
    },
  },
}
