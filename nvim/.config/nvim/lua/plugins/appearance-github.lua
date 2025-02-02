local M = {
  'projekt0n/github-nvim-theme',
  enabled = true,
  lazy = false,
  name = 'github-theme',
  priority = 1000,
}

M.opts = {
  styles = {
    comments = 'italic',
    keywords = 'bold',
    types = 'italic,bold',
  },
}

M.config = function(_, opts)
  require('github-theme').setup(opts)
  vim.cmd.colorscheme('github_dark')
end

return M
