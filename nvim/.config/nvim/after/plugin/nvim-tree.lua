local nvim_tree_status, nvim_tree = pcall(require, 'nvim-tree')

if not nvim_tree_status then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
nvim_tree.setup({
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
  vim.keymap.set('n', '<C-e>', nvim_tree.toggle, { silent = true }),
})
