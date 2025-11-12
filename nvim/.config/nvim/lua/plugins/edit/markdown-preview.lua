local function load()
  vim.pack.add({
    { src = 'https://github.com/iamcco/markdown-preview.nvim' },
  })

  vim.fn['mkdp#util#install']()

  vim.g.mkdp_filetypes = { 'markdown' }
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_auto_close = 1
  vim.g.mkdp_refresh_slow = 0

  vim.keymap.set('n', '<leader>mp', vim.cmd.MarkdownPreview, { desc = 'Open markdown preview' })
end

local group = vim.api.nvim_create_augroup('my.markdown-preview', {})

local cmd = {
  group = group,
  once = true,
  pattern = 'markdown',
  callback = load,
}

local events = { 'FileType' }

vim.api.nvim_create_autocmd(events, cmd)
