return {
  'folke/trouble.nvim',
  enabled = false,
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
  opts = {},
}
