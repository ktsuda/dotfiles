return {
  'folke/which-key.nvim',
  enable = true,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer local keymaps',
    },
  },
  opts = {},
}
