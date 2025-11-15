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
vim.keymap.set('n', '<leader>gc', p.git_log)
vim.keymap.set('n', '<leader>gl', p.git_log_file)
vim.keymap.set('n', '<leader>gb', p.git_branches)
vim.keymap.set('n', '<leader>gs', p.git_status)
vim.keymap.set('n', '<leader>gd', p.git_diff)

vim.keymap.set('n', '<C-s>', function()
  p.projects({
    dev = { '~/src', '~/go', '~/Projects' },
    patterns = { '.git' },
    max_depth = 5,
    recent = true,
  })
end)

local grep_opts = {
  hidden = true,
  ignored = true,
}

vim.keymap.set('n', '<leader>sa', function()
  p.grep(grep_opts)
end)

vim.keymap.set({ 'n', 'x' }, '<leader>sw', function()
  p.grep_word(grep_opts)
end)
