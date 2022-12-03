local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then return end
local actions_status, telescope_actions = pcall(require, 'telescope.actions')
if not actions_status then return end
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-H',
      '--column',
      '-n',
      '-S',
      '-uu',
    },
    file_ignore_patterns = {
      '%.git/.*',
      'node_modules/.*',
      '.npm/.*',
      '.vscode/.*',
      '.cache/.*',
      '.gem/.*',
      '%.DS_Store',
      '%.jpg$',
      '%.JPG$',
      '%.jpeg',
      '%.png$',
      '%.PNG$',
    },
    mappings = {
      i = {
        ['<C-u>'] = telescope_actions.preview_scrolling_up,
        ['<C-d>'] = telescope_actions.preview_scrolling_down,
        ['<C-k>'] = telescope_actions.results_scrolling_up,
        ['<C-j>'] = telescope_actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    project = {
      base_dirs = {
        { path = vim.env.GHQ_ROOT, max_depth = 4 },
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

pcall(telescope.load_extension, 'project')
pcall(telescope.load_extension, 'fzf')

local builtin_status, telescope_builtin = pcall(require, 'telescope.builtin')
if not builtin_status then return end
local telescope_custom = {
  find_repo = function()
    telescope_builtin.find_files({
      cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
    })
  end,
  grep_repo = function()
    telescope_builtin.live_grep({
      cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
    })
  end,
  ghq_list = function()
    telescope.extensions.project.project({ display_type = 'full' })
  end,
}
vim.keymap.set('n', '<C-s>', telescope_custom.ghq_list, { silent = true })
vim.keymap.set('n', '<C-p>', telescope_custom.find_repo, { silent = true })
vim.keymap.set('n', '<leader>ug', telescope_custom.grep_repo, { silent = true })
vim.keymap.set('n', '<leader>uu', telescope_builtin.find_files, { silent = true })
vim.keymap.set('n', '<leader>uk', telescope_builtin.keymaps, { silent = true })
vim.keymap.set('n', '<leader>ub', telescope_builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>us', telescope_builtin.grep_string, { silent = true })
vim.keymap.set('n', '<leader>gc', telescope_builtin.git_commits, { silent = true })
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { silent = true })
vim.keymap.set('n', '<leader>gs', telescope_builtin.git_status, { silent = true })
vim.keymap.set('n', '<leader>gt', telescope_builtin.git_stash, { silent = true })
