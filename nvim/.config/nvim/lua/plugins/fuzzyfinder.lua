local utils = require('utils.fuzzyfinder')

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  pin = true,
  keys = {
    { '<C-s>', utils.extension('repos', 'project'), desc = 'find repos' },
    { '<C-p>', utils.custom('files'), desc = 'find files' },
    { '<leader>ug', utils.custom('grep'), desc = 'grep string' },
    { '<leader>uk', utils.custom('keymaps'), desc = 'list keymaps' },
    { '<leader>ub', utils.custom('buffers'), desc = 'list buffers' },
    { '<leader>gc', utils.custom('git_commits', {
      git_command = {
        'git',
        'log',
        '--all',
        '--date=short',
        '--pretty=oneline',
        '--format=%h %ad %cn %s %d',
      },
    }), desc = 'git log' },
    { '<leader>gb', utils.custom('git_branches'), desc = 'git branch' },
    { '<leader>ps', utils.custom('treesitter'), desc = 'parse tree' },
  },
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
  end,
}
