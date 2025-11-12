local function load()
vim.pack.add({
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/kyazdani42/nvim-web-devicons' },
})

local ll_status, ll = pcall(require, 'lualine')
if not ll_status then
  return
end

ll.setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
  },
  extensions = {
    'quickfix',
    'fugitive',
    'neo-tree',
    'oil',
    'fzf',
    'lazy',
  },
})
end

local group = vim.api.nvim_create_augroup('my.lualine', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
