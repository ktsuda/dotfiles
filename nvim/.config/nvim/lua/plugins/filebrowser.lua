return {
  'kyazdani42/nvim-tree.lua',
  keys = {
    { '<C-e>', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree' },
  },
  opts = {
    disable_netrw = true,
    update_cwd = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    diagnostics = {
      enable = true,
    },
    git = {
      ignore = false,
    },
    view = {
      width = 48,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local function keymap_opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      vim.keymap.set('n', '<CR>', api.node.open.edit, keymap_opts('Open'))
      vim.keymap.set('n', 'o', api.node.open.edit, keymap_opts('Open'))
      vim.keymap.set('n', 'l', api.node.open.preview, keymap_opts('Open Preview'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, keymap_opts('Close Directory'))
      vim.keymap.set('n', 'v', api.node.open.vertical, keymap_opts('Open: Vertical Split'))
      vim.keymap.set('n', 'I', api.tree.toggle_hidden_filter, keymap_opts('Toggle Dotfiles'))
      vim.keymap.set('n', 'H', api.tree.toggle_gitignore_filter, keymap_opts('Toggle Git Ignore'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, keymap_opts('Copy Name'))
      vim.keymap.set('n', 'gy', api.fs.copy.relative_path, keymap_opts('Copy Relative Path'))
      vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, keymap_opts('Copy Absolute Path'))
    end,
  },
  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require('nvim-tree').setup(opts)
  end,
}
