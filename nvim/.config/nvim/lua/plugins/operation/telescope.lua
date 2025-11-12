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
    }, -- for live grep
    mappings = {
      i = {
        ['<C-u>'] = 'preview_scrolling_up',
        ['<C-d>'] = 'preview_scrolling_down',
        -- ['<C-j>'] = 'results_scrolling_down',
        -- ['<C-k>'] = 'results_scrolling_up',
        ['<C-b>'] = 'cycle_history_next',
        ['<C-f>'] = 'cycle_history_prev',
        ['<C-n>'] = 'move_selection_next',
        ['<C-p>'] = 'move_selection_previous',
      },
    },
  },
  pickers = { find_files = { hidden = true } },
})

local opts = {}
local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
if is_inside_work_tree then
  opts.cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
end

vim.keymap.set('n', '<C-p>', function()
  tb.find_files(opts)
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>sa', function()
  tb.live_grep(opts)
end, { desc = 'Grep string' })

vim.keymap.set('n', '<leader>sw', function()
  tb.grep_string(opts)
end, { desc = 'Grep string under cursor' })

vim.keymap.set('n', '<leader>sk', tb.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sb', tb.buffers, { desc = 'Search buffers' })

vim.keymap.set('n', '<leader>/', function()
  tb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 20,
    previewer = false,
  }))
end, { desc = 'Search current buffer' })
vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = 'Telescope: Search helptags' })

vim.keymap.set('n', '<leader>gl', function()
  tb.git_commits({
    git_command = {
      'git',
      'log',
      '--all',
      '--date=short',
      '--pretty=oneline',
      '--format=%h %ad %cn %s %d',
    },
  })
end, { desc = 'Search current buffer' })
