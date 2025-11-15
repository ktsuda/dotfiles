vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.8' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

local t_status, t = pcall(require, 'telescope')
if not t_status then
  return
end

local tb = require('telescope.builtin')

t.setup({
  defaults = {
    path_display = { 'truncate' },
    vimgrep_arguments = {
      'rg',
      '--with-filename',
      '--column',
      '--line-number',
      '--smart-case',
      '--no-heading',
      '--hidden',
      '--no-binary',
    }, -- for live_grep and grep_string
    mappings = {
      i = {
        ['<C-u>'] = 'results_scrolling_up',
        ['<C-d>'] = 'results_scrolling_down',
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-n>'] = 'move_selection_next',
        ['<C-p>'] = 'move_selection_previous',
        ['<C-f>'] = 'cycle_history_next',
        ['<C-b>'] = 'cycle_history_prev',
      },
    },
  },
  pickers = { find_files = { hidden = true } },
})

local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'

vim.keymap.set('n', '<C-p>', function()
  if is_inside_work_tree then
    tb.git_files({ show_untracked = true })
  else
    tb.find_files()
  end
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>sa', function()
  if is_inside_work_tree then
    tb.live_grep({ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] })
  else
    tb.live_grep()
  end
end, { desc = 'Grep string' })

vim.keymap.set('n', '<leader>sw', function()
  if is_inside_work_tree then
    tb.grep_string({ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] })
  else
    tb.grep_string()
  end
end, { desc = 'Grep string under cursor' })

vim.keymap.set('n', '<leader>/', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
vim.keymap.set('n', '<leader>sk', tb.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sb', tb.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = 'Search helptags' })
vim.keymap.set('n', '<leader>gc', tb.git_commits, { desc = 'Git log' })
vim.keymap.set('n', '<leader>gl', tb.git_bcommits, { desc = 'Git log for the current buffer' })
