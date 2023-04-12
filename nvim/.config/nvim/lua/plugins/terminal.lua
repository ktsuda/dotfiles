return {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermToggle', 'FloatermNew' },
  keys = {
    { '<leader>tt', '<cmd>FloatermToggle<cr>', mode = 'n', desc = 'terminal' },
    { '<leader>tt', '<C-\\><C-n>FloatermToggle<cr>', mode = 't', desc = 'terminal' },
    { '<leader>ts', '<cmd>FloatermNew tig status<cr>', desc = 'tig status' },
    { '<leader>gl', '<cmd>FloatermNew --height=1.0 tig %<cr>', desc = 'git log -p' },
  },
}
