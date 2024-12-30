vim.g.mapleader = ' ' -- <Leader> in a global plugin
vim.g.maplocalleader = ' ' -- <LocalLeader> in a filetype plugin
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.colorcolumn = '+1'

if vim.fn.has('mac') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus' -- install xsel or xclip
end

