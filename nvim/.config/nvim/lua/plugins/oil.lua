return {
  'stevearc/oil.nvim',
  enabled = true,
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  keys = {
    {
      '<C-e>',
      function()
        require('oil').toggle_float()
      end,
      desc = 'Neotree',
    },
  },
  opts = {
    default_file_explorer = true,
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['l'] = 'actions.select',
      ['|'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['"'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['t'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
      ['v'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['h'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory', mode = 'n' },
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
    },
  },
}
