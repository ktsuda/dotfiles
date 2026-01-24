local s = require('snacks')
local p = require('snacks.picker')
local t = require('snacks.toggle')

local opts = {}
local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
if is_inside_work_tree then
  opts = { cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }
end

vim.keymap.set('n', '<leader>/', p.lines)
vim.keymap.set('n', '<leader>sk', p.keymaps)
vim.keymap.set('n', '<C-b>', p.buffers)
vim.keymap.set('n', '<leader>sh', p.help)
vim.keymap.set('n', '<leader>gl', p.git_log_file)
vim.keymap.set('n', '<leader>gs', p.git_status)
vim.keymap.set('n', '<C-g>', s.lazygit.open)

vim.keymap.set('n', '<C-p>', function()
  p.smart(opts)
end)

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

vim.keymap.set('n', '<C-e>', function()
  p.explorer(opts)
end)

t.zoom():map('<leader>z')
