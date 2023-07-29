return {
  'kyazdani42/nvim-tree.lua',
  keys = {
    { '<C-e>', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree' },
  },
  opts = {
    update_cwd = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    view = {
      adaptive_size = true,
      mappings = {
        custom_only = false,
        list = {
          { key = { '<CR>', 'o' }, action = 'edit' },
          { key = 'l', action = 'preview' },
          { key = '<C-e>', action = '' },
          { key = 'h', action = 'close_node' },
          { key = 'v', action = 'vsplit' },
          { key = 'I', action = 'toggle_dotfiles' },
          { key = 'H', action = 'toggle_ignored' },
          { key = 'y', action = 'copy_name' },
          { key = 'gy', action = 'copy_path' },
          { key = 'Y', action = 'copy_absolute_path' },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require('nvim-tree').setup(opts)
  end,
}
