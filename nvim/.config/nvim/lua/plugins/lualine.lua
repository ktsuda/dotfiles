local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then return end
lualine.setup({
  options = {
    theme = 'auto',
    icons_enabled = false,
  },
  extensions = {
    'quickfix',
    'fugitive',
    'nvim-tree',
    'fzf',
  },
})
