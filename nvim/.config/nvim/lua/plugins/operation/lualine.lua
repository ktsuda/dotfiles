vim.pack.add({
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/kyazdani42/nvim-web-devicons' },
})

local ll_status, ll = pcall(require, 'lualine')
if not ll_status then
  return
end

ll.setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
  },
  extensions = {
    'quickfix',
    'fugitive',
    'neo-tree',
    'oil',
    'fzf',
    'lazy',
  },
})
