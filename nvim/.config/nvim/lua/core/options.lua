vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.smartindent = true
vim.o.laststatus = 2
vim.wo.signcolumn = 'yes'
vim.o.foldmethod = 'marker'
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 50
vim.o.guicursor = ''
vim.o.colorcolumn = '80'
vim.o.background = 'dark'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.mouse = ''

if vim.fn.has('mac') == 1 then
  vim.o.clipboard = 'unnamed'
elseif vim.fn.has('win64') == 1 then
  vim.o.clipboard = 'unnamed'
elseif vim.fn.has('win32') == 1 then
  vim.o.clipboard = 'unnamed'
else
  vim.o.clipboard = 'unnamedplus'   -- install xsel or xclip
end
