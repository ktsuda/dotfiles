return {
  'rguruprakash/simple-note.nvim',
  enable = true,
  cmd = {'SimpleNoteList', 'SimpleNoteCreate', 'SimpleNotePickDirectory'},
  keys = {
    { '<leader>nl', '<cmd>SimpleNoteList<CR>', desc = 'Simplenote: List notes' },
    { '<leader>na', '<cmd>SimpleNoteCreate<CR>', desc = 'Simplenote: List notes' },
    { '<leader>nd', '<cmd>SimpleNotePickDirectory<CR>', desc = 'Simplenote: List notes' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    notes_dir = '~/src/github.com/ktsuda/home/app/notes/inbox/',
    notes_directories = {
      '~/Projects/notes/inbox/',
      '~/Documents/notes/inbox/',
      '~/src/github.com/ktsuda/home/app/notes/inbox/'
    },
    telescope_new = '<C-n>',
    telescope_delete = '<C-d>',
    telescope_rename = '<C-r>',
    telescope_change_directory = '<C-c>',
  },
  config = function(_, opts)
    require('simple-note').setup(opts)
  end,
}
