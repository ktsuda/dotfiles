return  {
  'laytan/tailwind-sorter.nvim',
  enabled = false,
  ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
  },
  build = 'cd formatter && npm ci && npm run build',
  cond = function()
    return vim.fn.executable('npm') == 1
  end,
  opts = {
    on_save_enabled = true,
  },
}

