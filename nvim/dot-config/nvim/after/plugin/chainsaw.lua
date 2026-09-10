local ok, chainsaw=pcall(require, 'chainsaw')
if not ok then
  return
end

vim.keymap.set("n", "<leader>lv", chainsaw.variableLog)
vim.keymap.set("n", "<leader>lo", chainsaw.objectLog)
vim.keymap.set("n", "<leader>lp", chainsaw.typeLog)
vim.keymap.set("n", "<leader>la", chainsaw.assertLog)
vim.keymap.set("n", "<leader>le", chainsaw.emojiLog)
vim.keymap.set("n", "<leader>lm", chainsaw.messageLog)
vim.keymap.set("n", "<leader>lt", chainsaw.timeLog)
vim.keymap.set("n", "<leader>ld", chainsaw.debugLog)
vim.keymap.set("n", "<leader>ls", chainsaw.stacktraceLog)
vim.keymap.set("n", "<leader>lc", chainsaw.clearLog)
vim.keymap.set("n", "<leader>lr", chainsaw.removeLogs)
