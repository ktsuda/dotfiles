vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '+1'
vim.opt.smartindent = true

if vim.fn.has('mac') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus' -- install xsel or xclip
end
