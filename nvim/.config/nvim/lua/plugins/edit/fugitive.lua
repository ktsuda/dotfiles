local function load()
  vim.pack.add({
    { src = 'https://github.com/tpope/vim-fugitive' },
    { src = 'https://github.com/tpope/vim-rhubarb' },
  })
end

local function load_and_cmd(cmd)
  load()
  vim.cmd(cmd)
end

vim.keymap.set('n', '<leader>gs', function()
  load_and_cmd('0G')
end, { desc = 'Git status' })

vim.keymap.set('n', '<leader>gd', function()
  load_and_cmd('Gdiff')
end, { desc = 'Git diff' })

vim.keymap.set('n', '<leader>gr', function()
  load_and_cmd('GBrowse')
end, { desc = 'Browse repo' })
