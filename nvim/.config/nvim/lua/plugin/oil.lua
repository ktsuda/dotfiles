vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
})

require('oil').setup({
  keymaps = {
    ['<C-p>'] = false,
    ['?'] = { 'actions.show_help', mode = 'n' },
    ['<CR>'] = { 'actions.select', mode = 'n' },
    ['gl'] = { 'actions.select', mode = 'n' },
    [';'] = { 'actions.select', opts = { vertical = true }, mode = 'n' },
    ['-'] = { 'actions.select', opts = { horizontal = true }, mode = 'n' },
    ['gh'] = { 'actions.parent', mode = 'n' },
    ['gv'] = { 'actions.preview', mode = 'n' },
    ['<Esc>'] = { 'actions.close', mode = 'n' },
    ['q'] = { 'actions.close', mode = 'n' },
    ['<C-g>'] = { 'actions.refresh', mode = 'n' },
    ['g.'] = { 'actions.open_cwd', mode = 'n' },
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
