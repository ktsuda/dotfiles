vim.g.mapleader = ' '
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.autoindent = true
vim.o.laststatus = 2
vim.wo.signcolumn = 'yes'
vim.o.foldmethod = 'marker'
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.api.nvim_command('colorscheme neosolarized')
vim.o.background = 'dark'
vim.api.nvim_command('highlight Normal ctermbg=none guibg=none')
vim.api.nvim_command('highlight NonText ctermbg=none guibg=none')
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 100

if vim.fn.has('mac') == 1 then
  vim.opt.clipboard = 'unnamed'
elseif vim.fn.has('win64') == 1 then
  vim.opt.clipboard = 'unnamed'
elseif vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus'
end
