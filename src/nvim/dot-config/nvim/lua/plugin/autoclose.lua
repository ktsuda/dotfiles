vim.pack.add({
  { src = "https://github.com/m4xshen/autoclose.nvim" },
})

require("autoclose").setup({
  keys = {
    ["'"] = { escape = true, close = false, pair = "''" },
  },
  options = {
    auto_indent = true,
  }
})
