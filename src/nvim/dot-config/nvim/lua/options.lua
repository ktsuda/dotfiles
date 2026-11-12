vim.o.signcolumn = "yes:2"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 120
vim.o.laststatus = 3
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.cmdheight = 1
vim.opt.clipboard = "unnamedplus" -- See :checkhealth provider

-- copy on select: yank a mouse selection when the drag ends
vim.keymap.set("x", "<LeftRelease>", "y")
