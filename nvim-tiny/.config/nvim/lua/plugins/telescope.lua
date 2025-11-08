vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.8' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-project.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
})

require('telescope').setup({
  defaults = {
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
        ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
        ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-j>'] = require('telescope.actions').results_scrolling_down,
        ['<C-k>'] = require('telescope.actions').results_scrolling_up,
        ['<C-f>'] = require('telescope.actions').cycle_history_next,
        ['<C-b>'] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
  pickers = { find_files = { hidden = true } },
  extensions = {
    project = {
      base_dirs = {
        { path = vim.env.HOME .. '/src', max_depth = 5 },
        { path = (vim.env.GOPATH or (vim.env.HOME .. '/go')) .. '/src', max_depth = 4 },
        { path = vim.env.HOME .. '/Projects', max_depth = 4 },
      },
      hidden_files = true,
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files()
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>sa', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Grep strings' })

vim.keymap.set('n', '<leader>sk', function()
  require('telescope.builtin').keymaps()
end, { desc = 'Search keymaps' })

vim.keymap.set('n', '<leader>sb', function()
  require('telescope.builtin').buffers()
end, { desc = 'Search buffers' })

vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end, { desc = 'Search current buffer' })

vim.keymap.set('n', '<leader>gl', function()
  require('telescope.builtin').git_commits({
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

pcall(require('telescope').load_extension, 'project')

vim.keymap.set('n', '<C-s>', function()
  require('telescope').extensions.project.project({
    display_type = 'full',
  })
end, { desc = 'Search repos' })
