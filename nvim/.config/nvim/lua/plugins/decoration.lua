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
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'trouble(x) toggle(x)' },
      { 'gr', '<cmd>Trouble lsp_references toggle<cr>', desc = '[g]oto [r]eferences' },
      { 'gd', '<cmd>Trouble lsp_definitions toggle<cr>', desc = '[g]oto [d]efinitions' },
      { 'gi', '<cmd>Trouble lsp_implementations toggle<cr>', desc = '[g]oto [i]mplementaitons' },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
}
