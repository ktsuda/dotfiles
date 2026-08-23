vim.g.mapleader = " "

require("options")
require("lsp")
require("colorscheme")
-- require("netrw")
require("statusline")
-- require("find")
require("fuzzyfind")
require("grep")
require("autocmd")
require("diagnostics")
require("formatting")
pcall(require, "plugin")
