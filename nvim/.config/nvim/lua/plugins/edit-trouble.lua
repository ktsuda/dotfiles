return {
  'folke/trouble.nvim',
  enabled = false,
  cmd = 'Trouble',
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: Toggle diagnostics' },
    { 'gr', '<cmd>Trouble lsp_references toggle<cr>', desc = 'Trouble: Goto references' },
    { 'gd', '<cmd>Trouble lsp_definitions toggle<cr>', desc = 'Trouble: Goto definitions' },
    { 'gi', '<cmd>Trouble lsp_implementations toggle<cr>', desc = 'Trouble: Goto implementaitons' },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {},
}
