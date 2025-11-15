local function load()
  vim.pack.add({
    { src = 'https://github.com/iamcco/markdown-preview.nvim' },
  })

  vim.fn['mkdp#util#install']()

  vim.g.mkdp_filetypes = { 'markdown' }
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_auto_close = 1
  vim.g.mkdp_refresh_slow = 0

  vim.keymap.set('n', '<leader>mp', vim.cmd.MarkdownPreviewToggle, { desc = 'Toggle markdown preview' })
end

local group = vim.api.nvim_create_augroup('my.markdown-preview', {})

local cmd = {
  group = group,
  once = true,
  pattern = { '*.md', '*.markdown', '*.mkd' },
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
