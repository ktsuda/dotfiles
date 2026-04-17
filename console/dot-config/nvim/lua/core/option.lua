vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.signcolumn = 'yes:2'
vim.opt.colorcolumn = '+1'
vim.opt.winborder = 'single'
vim.opt.colorcolumn = '+1'
vim.opt.textwidth = 120
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.termguicolors = false
vim.g.t_co = 16

-- default: 'jcroql'
vim.opt.formatoptions = {
  t = true,
  c = true,
  r = true,
  o = false,
  q = false,
  l = true,
  n = true,
  j = true,
  p = true,
  m = true,
  B = true,
  [']'] = true,
}

if vim.fn.has('mac') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus' -- install xsel or xclip
end
