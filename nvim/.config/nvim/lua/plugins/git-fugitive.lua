return {
  'ktsuda/vim-fugitive',
  enabled = true,
  branch = 'signoff',
  pin = true,
  cmd = { 'G', 'Git', 'Gdiff', 'GBrowse' },
  keys = {
    { '<leader>gs', '<cmd>0G<cr>', desc = '[g]it [s]tatus' },
    { '<leader>gd', '<cmd>Gdiff<cr>', desc = '[g]it [d]iff' },
    { '<leader>br', '<cmd>GBrowse<cr>', desc = '[b]rowse [r]epo' },
  },
  dependencies = {
    'tpope/vim-rhubarb',
  },
}
