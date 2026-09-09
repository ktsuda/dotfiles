vim.pack.add({
  { src = "https://github.com/martindur/zdiff.nvim" },
})

require("zdiff").setup({
  default_expanded = false,
  default_branch = "main",
  keymaps = {
    goto_file = "<CR>",
    toggle = "<Tab>",
    close = "q",
    refresh = "R",
    toggle_mode = "m",
    help = "?",
    yank_ref = "gy",
  },
})
