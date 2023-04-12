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
        sections = {
          lualine_b = {
            { 'branch' },
          },
          lualine_c = {
            {
              'diff',
              colored = true,
              diff_color = {
                added = 'DiffAdd',
                modified = 'DiffChange',
                removed = 'DiffDelete',
              },
            },
            { 'diagnostics' },
            { 'filename' },
          },
        },
        extensions = {
          'quickfix',
          'fugitive',
          'nvim-tree',
          'fzf',
        },
      },
    },
  }
