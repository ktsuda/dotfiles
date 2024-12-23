vim.g.mapleader = ' ' -- <Leader> in a global plugin
vim.g.maplocalleader = ' ' -- <LocalLeader> in a filetype plugin
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.laststatus = 2
vim.opt.signcolumn = 'yes'
vim.opt.foldmethod = 'marker'
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 50
vim.opt.guicursor = ''
vim.opt.breakindent = true
vim.opt.textwidth = 78
vim.opt.colorcolumn = '+1'
vim.opt.background = 'dark'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'
vim.opt.formatoptions:append({ m = true, M = true, l = false })
vim.opt.diffopt:append('vertical')
vim.opt.spell = true
vim.opt.spelllang:append('cjk')
vim.opt.whichwrap:append({
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
  h = true,
  l = true,
})
vim.opt.autoread = true

if vim.fn.has('mac') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus' -- install xsel or xclip
end
