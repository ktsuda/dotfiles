local function load()
  vim.pack.add({
    { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  })

  vim.g.table_mode_corner = '|'

  vim.keymap.set('n', '<leader>mt', vim.cmd.TableModeToggle, { desc = 'Toggle markdown table mode' })
end

local group = vim.api.nvim_create_augroup('my.markdown-table-mode', {})

local cmd = {
  group = group,
  once = true,
  pattern = 'markdown',
  callback = load,
}

local events = { 'FileType' }

vim.api.nvim_create_autocmd(events, cmd)
