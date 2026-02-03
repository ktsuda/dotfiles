vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ timeout_ms = 500, lsp_format = 'fallback' })
end)
-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
