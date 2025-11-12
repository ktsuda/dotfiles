local function load()
  vim.pack.add({
    { src = 'https://github.com/windwp/nvim-autopairs' },
  })

  require('nvim-autopairs').setup({
    disable_filetype = { 'TelescopePrompt', 'vim' },
  })
end

local group = vim.api.nvim_create_augroup('my.autopairs', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'InsertEnter', 'CmdlineEnter' }

vim.api.nvim_create_autocmd(events, cmd)
