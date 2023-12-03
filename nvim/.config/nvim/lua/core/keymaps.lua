local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map({ 'n', 'v' }, '<Space>', '<Nopp>', { silent = true }) -- nowait
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
map('n', '[q', '<cmd>cprevious<cr>')
map('n', ']q', '<cmd>cnext<cr>')
map('n', '<C-h>', '<cmd>bprev<cr>')
map('n', '<C-l>', '<cmd>bnext<cr>')
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>q', vim.diagnostic.setloclist)
map('n', '<leader>l', '<cmd>Lazy<cr>')
