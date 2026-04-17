vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ timeout_ms = 500, lsp_format = 'fallback' })
end)
