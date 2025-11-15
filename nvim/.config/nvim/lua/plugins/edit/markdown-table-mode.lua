local function load()
  vim.pack.add({
    { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  })

  vim.g.table_mode_corner = '|'
  vim.g.table_mode_disable_mappings = 1
  vim.g.table_mode_disable_tableize_mappings = 1

  vim.keymap.set('n', '<leader>mt', vim.cmd.TableModeToggle, { desc = 'Toggle markdown table mode' })
  vim.keymap.set({ 'v', 'x' }, '<leader>mc', vim.cmd.Tableize, { desc = 'Tableize' })
end

local group = vim.api.nvim_create_augroup('my.markdown-table-mode', {})

local cmd = {
  group = group,
  once = true,
  pattern = { '*.md', '*.markdown', '*.mkd' },
  callback = load,
}

local events = { 'InsertEnter', 'CmdlineEnter' }

vim.api.nvim_create_autocmd(events, cmd)
