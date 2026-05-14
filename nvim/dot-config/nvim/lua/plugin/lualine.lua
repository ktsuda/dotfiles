vim.pack.add({
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  -- { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

require('lualine').setup({
  options = {
    disabled_filetypes = {
      'oil',
      'snacks_picker_input',
      'snacks_dashboard',
    },
  },
})
