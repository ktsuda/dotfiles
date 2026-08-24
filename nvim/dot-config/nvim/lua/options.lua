vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.signcolumn = "yes:2"
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 120
vim.o.undofile = true
vim.o.autoread = true
vim.o.laststatus = 3
vim.o.cmdheight = 1

if vim.fn.has("mac") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
	vim.opt.clipboard = "unnamed"
else
	vim.opt.clipboard = "unnamedplus" -- install xsel or xclip
end
