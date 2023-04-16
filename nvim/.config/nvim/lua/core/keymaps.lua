vim.g.mapleader = ' '

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', 'Y', 'y$')
map('n', '[q', '<cmd>cprevious<cr>')
map('n', ']q', '<cmd>cnext<cr>')
map('n', '<C-h>', '<cmd>bprev<cr>')
map('n', '<C-l>', '<cmd>bnext<cr>')
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>q', vim.diagnostic.setloclist)
map('n', '<C-j>', '<C-w><C-j>', { noremap = true })
map('n', '<C-h>', '<C-w><C-h>', { noremap = true })
map('n', '<C-k>', '<C-w><C-k>', { noremap = true })
map('n', '<C-l>', '<C-w><C-l>', { noremap = true })
