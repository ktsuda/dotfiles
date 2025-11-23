local function load()
  vim.pack.add({
    { src = 'https://github.com/toppair/peek.nvim' },
  })

  -- build: deno task --quet build:fast
  vim.keymap.set('n', '<leader>mo', require('peek').open, { desc = 'Open Peek' })
end

local group = vim.api.nvim_create_augroup('my.peek', {})

local cmd = {
  group = group,
  pattern = 'markdown',
  callback = load,
}

local events = { 'FileType' }

vim.api.nvim_create_autocmd(events, cmd)
