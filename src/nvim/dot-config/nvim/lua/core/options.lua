vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "noselect"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 120
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.laststatus = 2
vim.opt.cmdheight = 1
vim.opt.clipboard = "unnamedplus" -- See :checkhealth provider
vim.opt.iskeyword:append("-")

-- copy on select: yank a mouse selection when the drag ends
vim.keymap.set("x", "<LeftRelease>", "y")
