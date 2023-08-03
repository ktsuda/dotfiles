return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<C-e>', '<cmd>Neotree toggle=true<cr>', desc = 'Neotree' },
  },
  opts = function(_, opts)
    return vim.tbl_extend('force', {
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
