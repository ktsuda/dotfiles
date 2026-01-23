vim.keymap.set('n', '<leader>ac', '<cmd>CopilotChat<cr>', { desc = 'Chat with Copilot' })
vim.opt.splitright = true

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('my.copilot', {}),
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})
