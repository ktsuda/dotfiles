vim.pack.add({
  { src = 'https://github.com/folke/snacks.nvim' },
})

local s_status, s = pcall(require, 'snacks')
if not s_status then
  return
end

s.setup({
  picker = {
    hidden = true,
    ignore = true,
    sources = {
      files = {
        hidden = true,
        ignore = true,
      },
    },
  },
  explorer = {
    replace_netrw = true,
    diagnostics = true,
    git_status = true,
    git_untracked = true,
    follow_file = true,
  },
})

local p = require('snacks.picker')

vim.keymap.set('n', '<C-p>', p.smart)
vim.keymap.set('n', '<C-e>', p.explorer)
vim.keymap.set('n', '<leader>/', p.lines)
vim.keymap.set('n', '<leader>sk', p.keymaps)
vim.keymap.set('n', '<leader>sb', p.buffers)
vim.keymap.set('n', '<leader>sh', p.help)
vim.keymap.set('n', '<leader>gl', s.lazygit.open)
vim.keymap.set('n', '<C-g>', s.lazygit.open)

vim.keymap.set('n', '<C-s>', function()
  p.projects({
    dev = { '~/src', '~/go', '~/Projects' },
    patterns = { '.git' },
    max_depth = 5,
    recent = true,
  })
end)

vim.keymap.set('n', '<leader>sa', function()
  p.git_grep({
    format = 'file',
    live = true,
    supports_live = true,
    untracked = true,
    submodlues = true,
  })
end)

vim.keymap.set({ 'n', 'x' }, '<leader>sw', function()
  p.git_grep({
    format = 'file',
    search = function(picker)
      return picker:word()
    end,
    live = true,
    supports_live = true,
    untracked = true,
    submodlues = true,
  })
end)

require('snacks.toggle').inlay_hints():map('gh')
require('snacks.toggle').line_number():map('<leader>l')
require('snacks.toggle').zoom():map('<leader>z')
