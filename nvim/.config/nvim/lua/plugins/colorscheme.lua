-- vim.api.nvim_command('colorscheme NeoSolarized')
local color_status, _ = pcall(vim.api.nvim_command, 'colorscheme Neosolarized')
if not color_status then return end
vim.o.background = 'dark'
vim.api.nvim_command('highlight Normal ctermbg=none guibg=none')
vim.api.nvim_command('highlight NonText ctermbg=none guibg=none')
