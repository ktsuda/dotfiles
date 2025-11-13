local function load()
  vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/kyazdani42/nvim-web-devicons' },
  })

  require('oil').setup({
    default_file_explorer = true,
    columns = {
      'icon',
      'permissions',
      -- 'size',
      -- 'mtime',
    },
    use_default_keymaps = false,
    keymaps = {
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['|'] = { 'actions.select', opts = { vertical = true } },
      ['"'] = { 'actions.select', opts = { horizontal = true } },
      ['v'] = 'actions.preview',
      ['<C-e>'] = { 'actions.close', mode = 'n' },
      ['<C-l>'] = 'actions.refresh',
      ['<BS>'] = { 'actions.parent', mode = 'n' },
      ['.'] = { 'actions.open_cwd', mode = 'n' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['I'] = { 'actions.toggle_hidden', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    },
    view_options = {
      show_hidden = true,
    },
    natural_order = 'fast',
    sort = {
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
    delete_to_trash = true,
  })
end

vim.keymap.set('n', '<C-e>', function()
  load()
  vim.cmd('Oil')
end, { desc = 'Open Oil' })
