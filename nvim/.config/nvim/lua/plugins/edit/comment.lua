local function load()
  vim.pack.add({
    { src = 'https://github.com/numToStr/Comment.nvim' },
  })

  require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = '^$',
    toggler = {
      line = '<leader>cc',
      block = '<leader>cb',
    },
    opleader = {
      line = '<leader>cc',
      block = '<leader>cb',
    },
    mappings = {
      basic = true,
      extra = false,
    },
  })
end

vim.keymap.set('n', '<leader>cc', function()
  load()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment linewise' })

vim.keymap.set('x', '<leader>cc', function()
  load()
  require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle comment linewise' })

vim.keymap.set('n', '<leader>cb', function()
  load()
  require('Comment.api').toggle.blockwise.current()
end, { desc = 'Toggle comment blockwise' })

vim.keymap.set('x', '<leader>cb', function()
  load()
  require('Comment.api').toggle.blockwise(vim.fn.visualmode())
end, { desc = 'Toggle comment blockwise' })
