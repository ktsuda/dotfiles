local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then
  return
end
local actions_status, telescope_actions = pcall(require, 'telescope.actions')
if not actions_status then
  return
end
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
      '%.local/.*',
      'node_modules/.*',
      '%.npm/.*',
      '%.vscode/.*',
      '%.cache/.*',
      '%.gem/.*',
      '%.rustup/.*',
      '%.cargo/.*',
      '%.deno/.*',
      '%.docker/.*',
      '%.fzf/.*',
      '%.gnupg/.*',
      '%.clangd/.*',
      '%.mozilla/.*',
      '%.mozc/.*',
      '%.dbus/.*',
      'snap/.*',
      '%.DS_Store',
      '%.jpg$',
      '%.JPG$',
      '%.jpeg',
      '%.png$',
      '%.PNG$',
    },
    mappings = {
      i = {
        ['<C-k>'] = telescope_actions.preview_scrolling_up,
        ['<C-j>'] = telescope_actions.preview_scrolling_down,
        ['<C-u>'] = telescope_actions.results_scrolling_up,
        ['<C-d>'] = telescope_actions.results_scrolling_down,
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
        { path = vim.env.HOME .. '/src', max_depth = 4 },
        { path = vim.env.GOPATH .. '/src', max_depth = 4 },
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
pcall(telescope.load_extension, 'zoxide')

local builtin_status, telescope_builtin = pcall(require, 'telescope.builtin')
if not builtin_status then
  return
end
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
  grep_string = function()
    telescope_builtin.grep_string({
      search = vim.fn.input('Grep > '),
    })
  end,
  git_commits = function()
    telescope_builtin.git_commits({
      git_command = {
        'git',
        'log',
        '--all',
        '--date=short',
        '--pretty=oneline',
        '--format=%h %ad %cn %s %d',
      },
    })
  end,
  zoxide_list = telescope.extensions.zoxide.list,
}

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<C-s>', telescope_custom.ghq_list)
map('n', '<leader>cd', telescope_custom.zoxide_list)
map('n', '<C-p>', telescope_custom.find_repo)
map('n', '<leader>ug', telescope_custom.grep_repo)
map('n', '<leader>uu', telescope_builtin.find_files)
map('n', '<leader>uk', telescope_builtin.keymaps)
map('n', '<leader>ub', telescope_builtin.buffers)
map('n', '<leader>us', telescope_custom.grep_string)
map('n', '<leader>gc', telescope_custom.git_commits)
map('n', '<leader>gb', telescope_builtin.git_branches)
map('n', '<leader>ps', telescope_builtin.treesitter)
