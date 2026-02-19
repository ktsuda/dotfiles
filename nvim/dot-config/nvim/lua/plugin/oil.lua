vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
})

require('oil').setup({
  keymaps = {
    ['g?'] = { 'actions.show_help', mode = 'n' },
    ['<CR>'] = { 'actions.select', mode = 'n' },
    ['l'] = { 'actions.select', mode = 'n' },
    [';'] = { 'actions.select', opts = { vertical = true }, mode = 'n' },
    ['-'] = { 'actions.select', opts = { horizontal = true }, mode = 'n' },
    ['t'] = { 'actions.select', opts = { tab = true }, mode = 'n' },
    ['V'] = { 'actions.preview', mode = 'n' },
    ['q'] = { 'actions.close', mode = 'n' },
    ['<Esc>'] = { 'actions.close', mode = 'n' },
    ['<C-l>'] = { 'actions.refresh', mode = 'n' },
    ['h'] = { 'actions.parent', mode = 'n' },
    ['_'] = { 'actions.open_cwd', mode = 'n' },
    ['`'] = { 'actions.cd', mode = 'n' },
    ['g~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
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
})
