return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      event = 'VeryLazy',
      version = '2.*',
      opts = {},
    },
  },
  keys = {
    { '<C-e>', '<cmd>Neotree toggle=true<cr>', desc = 'Neotree' },
  },
  opts = function(_, opts)
    return vim.tbl_extend('force', {
      close_if_last_window = true,
      sort_function = function(a, b)
        if a.type == b.type then
          return a.path < b.path
        else
          return a.type < b.type
        end
      end,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            'node_modules',
            '.git',
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        mappings = {
          ['o'] = 'open',
          ['l'] = { 'toggle_preview', config = { use_float = false } },
          ['I'] = 'toggle_hidden',
          ['C'] = 'close_all_subnodes',
          ['c'] = 'close_node',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['m'] = 'move',
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['d'] = 'delete',
          ['r'] = 'rename',
        },
      },
    }, opts or {})
  end,
}
