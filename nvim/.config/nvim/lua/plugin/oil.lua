vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
})

require('oil').setup({
  keymaps = {
    ['<C-h>'] = { 'actions.show_help', mode = 'n' },
    ['<CR>'] = { 'actions.select', mode = 'n' },
    ['<C-f>'] = { 'actions.select', mode = 'n' },
    [';'] = { 'actions.select', opts = { vertical = true }, mode = 'n' },
    ['-'] = { 'actions.select', opts = { horizontal = true }, mode = 'n' },
    ['<C-p>'] = { 'actions.preview', mode = 'n' },
    ['<Esc>'] = { 'actions.close', mode = 'n' },
    ['<C-l>'] = { 'actions.refresh', mode = 'n' },
    ['<BS>'] = { 'actions.parent', mode = 'n' },
    ['gh'] = { 'actions.open_cwd', mode = 'n' },
    ['gc'] = { 'actions.cd', mode = 'n' },
    ['gs'] = { 'actions.change_sort', mode = 'n' },
    ['gx'] = { 'actions.open_external', mode = 'n' },
    ['I'] = { 'actions.toggle_hidden', mode = 'n' },
    ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
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
