return {
  'dhruvasagar/vim-table-mode',
  enabled = true,
  ft = { 'markdown' },
  init = function()
    vim.g.table_mode_corner = '|'
    vim.keymap.set('n', '<leader>mt', vim.cmd.TableModeToggle, { desc = 'TableMode: Toggle table mode' })
  end,
}
