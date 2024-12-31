return {
  'iamcco/markdown-preview.nvim',
  enabled = true,
  build = 'cd app && yarn',
  ft = { 'markdown' },
  cond = function()
    return vim.fn.executable('yarn') == 1
  end,
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_refresh_slow = 0
    vim.keymap.set('n', '<leader>mp', vim.cmd.MarkdownPreview, {})
  end,
}
