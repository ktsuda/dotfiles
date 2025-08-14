return {
  'ishan9299/nvim-solarized-lua',
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.solarized_termtrans = 1
    vim.cmd.colorscheme('solarized')
  end,
}
