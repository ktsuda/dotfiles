vim.pack.add({
  { src = 'https://github.com/dhruvasagar/vim-table-mode' },
})

vim.g.table_mode_corner = '|'

vim.keymap.set('n', '<leader>mt', vim.cmd.TableModeToggle, { desc = 'Toggle markdown table mode' })
