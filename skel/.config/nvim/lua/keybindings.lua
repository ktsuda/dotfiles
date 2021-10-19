local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
vim.g.mapleader = ' '
keymap('n', '<C-p>', ':GFiles<CR>', opts)
keymap('n', '<C-n>', ':Files<CR>', opts)
keymap('', '<C-e>', ':NERDTreeToggle<CR>', opts)
keymap('n', 'Y', 'y$', opts)
keymap('n', '[q', ':cprevious<CR>', opts)
keymap('n', ']q', ':cnext<CR>', opts)
keymap('n', '<leader>t', ':TigOpenProjectRootDir<CR>', opts)
keymap('n', '<leader>T', ':TigOpenCurrentFile<CR>', opts)
keymap('n', '<leader>g', ':TigGrep<CR>', opts)
keymap('n', '<leader>b', ':TigBlame<CR>', opts)
keymap('n', '<leader>,', ':e '..vim.env.MYVIMRC..'<CR>', opts)
-- keymap('n', '<leader>.', ':luafile '..vim.env.MYVIMRC..'<CR>', opts)
keymap('n', '<leader>.', ':so '..vim.env.MYVIMRC..'<CR>', opts)
