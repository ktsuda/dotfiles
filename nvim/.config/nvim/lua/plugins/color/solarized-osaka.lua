vim.pack.add({
  { src = 'https://github.com/craftzdog/solarized-osaka.nvim' },
})

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd.colorscheme('solarized-osaka')

require('solarized-osaka').setup({
  terminal_colors = true,
  sidebars = { 'qf', 'help', 'terminal', 'packer' },
})
