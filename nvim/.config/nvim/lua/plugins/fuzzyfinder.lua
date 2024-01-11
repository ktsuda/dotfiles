local utils = require('utils.fuzzyfinder')

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  pin = true,
  keys = {
    { '<C-s>', utils.extension('repos', 'project'), desc = 'search repos' },
    { '<leader>sr', utils.extension('repos', 'project'), desc = '[s]earch [r]epos' },
    { '<C-p>', utils.custom('files'), desc = 'search files' },
    { '<leader>sf', utils.custom('files'), desc = '[s]earch [f]iles' },
    { '<leader>sg', utils.custom('grep'), desc = '[s]earch string by [g]rep' },
    { '<leader>sk', utils.custom('keymaps'), desc = '[s]earch [k]eymaps' },
    { '<leader>sb', utils.custom('buffers'), desc = '[s]earch [b]uffers' },
    { '<leader>gl', utils.custom('git_log'), desc = '[g]it [l]og' },
    { '<leader>gb', utils.custom('git_branches'), desc = '[g]it [b]ranch' },
    { '<leader>/', utils.custom('string'), desc = '[/] search in current buffer' },
  },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  opts = function()
    local telescope_actions = require('telescope.actions')
    return {
      defaults = {
        winblend = 20,
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
          '.next/.*',
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
            utils.base_dir(vim.env.HOME .. '/src', 5),
            utils.base_dir((vim.env.GOPATH or '') .. '/src', 4),
            utils.base_dir(vim.env.HOME .. '/Projects', 4),
          },
          hidden_files = true,
        },
        file_browser = {
          hijack_netrw = true,
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
    pcall(telescope.load_extension, 'file_browser')
    pcall(telescope.load_extension, 'fzf')
  end,
}
