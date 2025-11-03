-- vim: set ts=2 sw=2 sts=2 et:
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- nowait
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({
    count = -1,
  })
end, { desc = "Diagnostic: Previous diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({
    count = 1,
  })
end, { desc = "Diagnostic: Next diagnostic" })
