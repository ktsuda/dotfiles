local function hl()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#cba6f7" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#89b4fa" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#f9e2af", bold = true })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = hl })
vim.cmd.colorscheme("catppuccin")
