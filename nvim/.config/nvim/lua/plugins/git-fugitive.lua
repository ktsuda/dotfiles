return {
  'tpope/vim-fugitive',
  enabled = true,
  branch = 'signoff',
  pin = true,
  cmd = { 'G', 'Git', 'Gdiff', 'GBrowse' },
  keys = {
    { '<leader>gs', '<cmd>0G<cr>', desc = 'Fugitive: Git status' },
    { '<leader>gd', '<cmd>Gdiff<cr>', desc = 'Fugitive: Git diff' },
    { '<leader>br', '<cmd>GBrowse<cr>', desc = 'Fugitive: Browse repo' },
  },
  dependencies = {
    'tpope/vim-rhubarb',
  },
}
