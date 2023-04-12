return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  pin = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    { 'nvim-telescope/telescope-project.nvim' },
  },
  opts = function()
    local telescope_actions = require('telescope.actions')
    return {
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
    }
  end,
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    pcall(telescope.load_extension, 'project')
    pcall(telescope.load_extension, 'fzf')
    local telescope_builtin = require('telescope.builtin')
    local telescope_custom = {
      find_files = function()
        if vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true' then
          telescope_builtin.find_files({
            cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
          })
        else
          telescope_builtin.find_files()
        end
      end,
      grep_string = function()
        if vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true' then
          telescope_builtin.live_grep({
            cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
          })
        else
          telescope_builtin.grep_string({
            search = vim.fn.input('Grep > '),
          })
        end
      end,
      ghq_list = function()
        telescope.extensions.project.project({ display_type = 'full' })
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
    }
    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<C-s>', telescope_custom.ghq_list)
    map('n', '<C-p>', telescope_custom.find_files)
    map('n', '<leader>ug', telescope_custom.grep_string)
    map('n', '<leader>uk', telescope_builtin.keymaps)
    map('n', '<leader>ub', telescope_builtin.buffers)
    map('n', '<leader>gc', telescope_custom.git_commits)
    map('n', '<leader>gb', telescope_builtin.git_branches)
    map('n', '<leader>ps', telescope_builtin.treesitter)
  end,
}
