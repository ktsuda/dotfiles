vim.g.mapleader = " "

require("options")
require("lsp")
require("colorscheme")
-- require("netrw")
require("statusline")
require("ghq")
require("autocmd")
require("diagnostics")
require("formatter")
require("linter")
pcall(require, "plugin")
