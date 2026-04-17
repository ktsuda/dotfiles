local s = require('snacks')
local p = require('snacks.picker')
local t = require('snacks.toggle')

local opts = {}
local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
if is_inside_work_tree then
  opts = { cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }
end

local function is_tracked_by_git(bufnr)
  bufnr = bufnr or 0

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == '' then
    return false
  end

  filepath = vim.loop.fs_realpath(filepath) or filepath

  local root = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()

  if root.code ~= 0 then
    return false
  end

  local git_root = vim.trim(root.stdout)

  -- Ensure prefix match (safety check)
  if not filepath:find(git_root, 1, true) then
    return false
  end

  local relpath = filepath:sub(#git_root + 2)

  local result = vim.system({ 'git', 'ls-files', '--error-unmatch', relpath }, { text = true, cwd = git_root }):wait()

  return result.code == 0
end

vim.keymap.set('n', '<leader>/', p.lines)
vim.keymap.set('n', '<leader>sk', p.keymaps)
vim.keymap.set('n', '<C-b>', p.buffers)
vim.keymap.set('n', '<leader>sh', p.help)
vim.keymap.set('n', '<leader>gl', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if is_tracked_by_git(bufnr) then
    p.git_log_file()
  else
    p.git_log()
  end
end)
vim.keymap.set('n', '<C-g>', function()
  if is_inside_work_tree then
    s.lazygit.open()
  else
    vim.notify('Snakcs.lazygit: Outside of git repo.', vim.log.levels.ERROR)
  end
end)

vim.keymap.set('n', '<C-p>', function()
  p.smart(opts)
end)

vim.keymap.set('n', '<C-s>', function()
  p.projects({
    dev = { '~/src', '~/go', '~/Projects', '~/Library/Mobile Documents/iCloud~md~obsidian/' },
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

t.zoom():map('<leader>z')
