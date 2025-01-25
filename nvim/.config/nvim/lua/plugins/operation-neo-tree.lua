return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = true,
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-e>', '<cmd>Neotree toggle=true<cr>', desc = 'Neotree: Toggle neotree' },
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
          ['oc'] = 'none',
          ['od'] = 'none',
          ['og'] = 'none',
          ['om'] = 'none',
          ['on'] = 'none',
          ['os'] = 'none',
          ['ot'] = 'none',
          ['s'] = 'none',
          ['|'] = 'open_vsplit',
          ['S'] = 'none',
          ['"'] = 'open_split',
          ['sc'] = 'order_by_created',
          ['sd'] = 'order_by_diagnostics',
          ['sg'] = 'order_by_git_status',
          ['sm'] = 'order_by_modified',
          ['sn'] = 'order_by_name',
          ['ss'] = 'order_by_size',
          ['st'] = 'order_by_type',
          ['o'] = 'open',
          ['v'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
          ['I'] = 'toggle_hidden',
          ['C'] = 'close_all_subnodes',
          ['c'] = 'close_node',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['m'] = 'move',
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['<space>'] = { 'toggle_node', nowait = true },
          ['l'] = 'open',
        },
      },
    }, opts or {})
  end,
}
