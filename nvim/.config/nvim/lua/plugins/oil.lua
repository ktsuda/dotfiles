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
    columns = {
      'icon',
      'permissions',
      'size',
      -- 'mtime',
    },
    watch_for_changes = true,
    keymaps = {
      ['?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['l'] = 'actions.select',
      ['|'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['"'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['t'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
      ['v'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['<Esc>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['h'] = 'actions.parent',
      ['w'] = 'actions.open_cwd',
      ['C'] = 'actions.cd',
      ['gs'] = 'actions.change_sort',
      ['o'] = 'actions.open_external',
      ['.'] = 'actions.toggle_hidden',
      ['g\\'] = false,
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
    },
    natural_order = false,
    case_insensitive = true,
  },
}
