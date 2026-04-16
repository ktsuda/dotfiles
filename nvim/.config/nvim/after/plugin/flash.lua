local f = require('flash')

-- stylua: ignore start
vim.keymap.set({'n', 'x', 'o'}, 'zk',      f.jump)
vim.keymap.set({'n', 'x', 'o'}, 'Zk',      f.treesitter)
vim.keymap.set({'o'},           'r',       f.remote)
vim.keymap.set({'x', 'o'},      'R',       f.treesitter_search)
vim.keymap.set({'c'},           '<C-s>',   f.toggle)
-- stylua: ignore end
