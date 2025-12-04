local function load()
  vim.pack.add({
    { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  }, {
    load = true,
  })

  vim.g.table_mode_corner = '|'
  vim.g.table_mode_delimiter = '\t'

  vim.keymap.set('n', '<leader>mt', ':TableModeToggle<cr>', { desc = 'Toggle markdown table mode' })
  vim.keymap.set({ 'n', 'v', 'x' }, '<leader>mc', ':Tableize<cr>', { desc = 'Tableize' })

  vim.cmd('TableModeEnable')
end

local group = vim.api.nvim_create_augroup('my.markdown-table-mode', {})

local cmd = {
  group = group,
  pattern = 'markdown',
  callback = load,
}

local events = { 'FileType' }

vim.api.nvim_create_autocmd(events, cmd)
