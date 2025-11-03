-- vim: set ts=2 sw=2 sts=2 et:
vim.g.mapleader = " "      -- <Leader> in a global plugin
vim.g.maplocalleader = " " -- <LocalLeader> in a filetype plugin
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.updatetime = 50
vim.opt.infercase = true
vim.opt.textwidth = 78
vim.opt.colorcolumn = "+1"
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.autoread = true

if vim.fn.has("mac") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  vim.opt.clipboard = "unnamed"
else
  vim.opt.clipboard = "unnamedplus" -- install xsel or xclip
end
