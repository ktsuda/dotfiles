vim.pack.add({
  -- { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/ktsuda/nvim-colorizer.lua", version = "fix/tbl_flatten" },
})

vim.o.termguicolors = true
require("colorizer").setup()

-- vim.pack.del({ "nvim-colorizer.lua" })
