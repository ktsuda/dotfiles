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
      dependencies = {
        { 'kyazdani42/nvim-web-devicons' },
      },
      opts = {
        options = {
          theme = 'gruvbox_dark',
          icons_enabled = true,
        },
        extensions = {
          'quickfix',
          'fugitive',
          'nvim-tree',
          'fzf',
          'lazy',
        },
      },
    },
  }
