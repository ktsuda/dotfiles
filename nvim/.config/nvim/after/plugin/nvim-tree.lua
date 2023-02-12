local nvim_tree_status, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_status then
  return
end
local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
nvim_tree.setup({
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        adaptive_size = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
                { key = '<C-e>',              action = '' },
                { key = 'h',                  cb = tree_cb('close_node') },
                { key = 'v',                  cb = tree_cb('vsplit') },
                { key = 'H',                  action = '' },
                { key = 'I',                  action = 'toggle_dotfiles' },
                { key = 'H',                  action = 'toggle_ignored' },
                { key = 'y',                  action = 'copy_name' },
                { key = 'gy',                 action = 'copy_path' },
                { key = 'Y',                  action = 'copy_absolute_path' },
            },
        },
    },
    vim.keymap.set('n', '<C-e>', nvim_tree.toggle, { silent = true }),
})
