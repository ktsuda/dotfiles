vim.pack.add({
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/kyazdani42/nvim-web-devicons' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/s1n7ax/nvim-window-picker' },
})

require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        'node_modules',
        '.git',
      },
      never_show = {
        '.DS_Store',
        'thumbs.db',
      },
      always_show_by_pattern = {
        '.config',
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
})

vim.keymap.set('n', '<C-e>', '<cmd>Neotree toggle=true<cr>', { desc = 'Toggle neotree' })
