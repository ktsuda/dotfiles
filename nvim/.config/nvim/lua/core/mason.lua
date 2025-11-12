local function load()
  vim.pack.add({
    { src = 'https://github.com/williamboman/mason.nvim' },
  })

  require('mason').setup()
end

local group = vim.api.nvim_create_augroup('my.mason', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
