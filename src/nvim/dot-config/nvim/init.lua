vim.g.mapleader = " "

require("options")
require("lsp")
require("colorscheme")
require("statusline")
require("autocmd")
require("diagnostics")
require("formatter")
require("linter")
pcall(require, "plugin")
