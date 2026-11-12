vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("oil").setup({
  keymaps = {
    -- stylua: ignore start
    ['<C-p>'] = false,
    ['`']     = false,
    ['<C-t>'] = false,
    ['<C-s>'] = false,
    ['<C-c>'] = false,
    ['g~']    = false,
    ['g\\']   = false,
    ['_']     = false,
    ['?']     = { 'actions.show_help',     mode = 'n' },
    ['<CR>']  = { 'actions.select',        mode = 'n' },
    ['<C-l>'] = { 'actions.select',        mode = 'n' },
    [';']     = { 'actions.select',        mode = 'n', opts = { vertical = true } },
    ['-']     = { 'actions.select',        mode = 'n', opts = { horizontal = true } },
    ['<BS>']  = { 'actions.parent',        mode = 'n' },
    ['<C-h>'] = { 'actions.parent',        mode = 'n' },
    ['gh']    = { 'actions.parent',        mode = 'n' },
    ['<Esc>'] = { 'actions.close',         mode = 'n' },
    ['q']     = { 'actions.close',         mode = 'n' },
    ['<C-e>'] = { 'actions.close',         mode = 'n' },
    ['<C-g>'] = { 'actions.refresh',       mode = 'n' },
    ['g.']    = { 'actions.open_cwd',      mode = 'n' },
    ['gc']    = { 'actions.cd',            mode = 'n' },
    ['gs']    = { 'actions.change_sort',   mode = 'n' },
    ['gx']    = { 'actions.open_external', mode = 'n' },
    ['I']     = { 'actions.toggle_hidden', mode = 'n' },
    ['gt']    = { 'actions.toggle_trash',  mode = 'n' },
    -- stylua: ignore end
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return vim.startswith(name, "..")
    end,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  float = {
    padding = 2,
    max_width = 0.8,
    max_height = 0.8,
    border = "rounded",
    preview_split = "right",
  },
  delete_to_trash = true,
})
