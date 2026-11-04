local ok, f = pcall(require, "fff")
if not ok then
  return false
end

vim.keymap.set("n", "<C-p>", f.find_files)
vim.keymap.set("n", "<leader>sa", f.live_grep)
vim.keymap.set({ "n", "x" }, "<leader>sw", f.live_grep_under_cursor)
vim.keymap.set("n", "<leader>ff", function()
  local dir = vim.fn.expand("%:p:h")
  f.find_files_in_dir(dir)
end)
