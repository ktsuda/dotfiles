vim.pack.add({
  { src = "https://github.com/chrisgrieser/nvim-chainsaw" },
})

local c = require("chainsaw")
c.setup()

vim.keymap.set("n", "<leader>lv", c.variableLog)
vim.keymap.set("n", "<leader>lo", c.objectLog)
vim.keymap.set("n", "<leader>lp", c.typeLog)
vim.keymap.set("n", "<leader>la", c.assertLog)
vim.keymap.set("n", "<leader>le", c.emojiLog)
vim.keymap.set("n", "<leader>lm", c.messageLog)
vim.keymap.set("n", "<leader>lt", c.timeLog)
vim.keymap.set("n", "<leader>ld", c.debugLog)
vim.keymap.set("n", "<leader>ls", c.stacktraceLog)
vim.keymap.set("n", "<leader>lc", c.clearLog)
vim.keymap.set("n", "<leader>lr", c.removeLogs)
