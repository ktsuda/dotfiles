local function load()
  vim.pack.add({
    { src = 'https://github.com/zbirenbaum/copilot.lua' },
  })

  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      lua = true,
      c = true,
      cpp = true,
      javascript = true,
      typescript = true,
      javascriptreact = true,
      typescriptreact = true,
      sh = true,
      zsh = true,
      python = true,
      ['*'] = false,
    },
  })
end

local group = vim.api.nvim_create_augroup('my.copilot', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'InsertEnter', 'CmdlineEnter' }


vim.api.nvim_create_autocmd(events, cmd)
