vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
})

require('oil').setup({
  keymaps = {
    -- stylua: ignore start
    ['<C-p>'] = false,
    ['?']     = { 'actions.show_help',     mode = 'n' },
    ['<CR>']  = { 'actions.select',        mode = 'n' },
    ['<C-l>'] = { 'actions.select',        mode = 'n' },
    ['gl']    = { 'actions.select',        mode = 'n' },
    [';']     = { 'actions.select',        mode = 'n', opts = { vertical = true }},
    ['-']     = { 'actions.select',        mode = 'n', opts = { horizontal = true }},
    ['<BS>']  = { 'actions.parent',        mode = 'n' },
    ['<C-h>'] = { 'actions.parent',        mode = 'n' },
    ['gh']    = { 'actions.parent',        mode = 'n' },
    ['gv']    = { 'actions.preview',       mode = 'n' },
    ['<Esc>'] = { 'actions.close',         mode = 'n' },
    ['q']     = { 'actions.close',         mode = 'n' },
    ['<C-g>'] = { 'actions.refresh',       mode = 'n' },
    ['g.']    = { 'actions.open_cwd',      mode = 'n' },
    ['gc']    = { 'actions.cd',            mode = 'n' },
    ['gs']    = { 'actions.change_sort',   mode = 'n' },
    ['gx']    = { 'actions.open_external', mode = 'n' },
    ['I']     = { 'actions.toggle_hidden', mode = 'n' },
    ['g\\']   = { 'actions.toggle_trash',  mode = 'n' },
    -- stylua: ignore end
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return vim.startswith(name, '..')
    end,
    sort = {
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
  },
  delete_to_trash = true,
})
