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
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>', desc = 'trouble(x) toggle(x)' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'trouble(x) [d]ocument' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'trouble(x) [w]orkspace' },
      { 'gr', '<cmd>TroubleToggle lsp_references<cr>', desc = '[g]oto [r]eferences' },
      { 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', desc = '[g]oto [d]efinitions' },
      { 'gi', '<cmd>TroubleToggle lsp_implementations<cr>', desc = '[g]oto [i]mplementaitons' },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
}
