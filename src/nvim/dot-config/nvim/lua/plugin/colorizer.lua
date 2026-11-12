vim.pack.add({
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
})

vim.opt.termguicolors = true
require("colorizer").setup()
