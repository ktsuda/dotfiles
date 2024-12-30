local utils = require('utils.custom-telescope')

return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  event = 'VeryLazy',
  tag = '0.1.8',
  branch = '0.1.x',
  keys = {
    { '<C-p>', utils.custom('files'), desc = 'search files' },
    { '<leader>sf', utils.custom('files'), desc = '[s]earch [f]iles' },
    { '<leader>sg', utils.custom('grep'), desc = '[s]earch string by [g]rep' },
    { '<leader>sk', utils.custom('keymaps'), desc = '[s]earch [k]eymaps' },
    { '<leader>sb', utils.custom('buffers'), desc = '[s]earch [b]uffers' },
    { '<leader>sh', utils.custom('help_tags'), desc = '[s]earch [h]elptags' },
    { '<leader>/', utils.custom('string'), desc = '[/] search in current buffer' },
    { '<leader>gl', utils.custom('git_log'), desc = '[g]it [l]og' },
    { '<leader>gb', utils.custom('git_branches'), desc = '[g]it [b]ranch' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    local telescope_actions = require('telescope.actions')
    return {
      defaults = {
        hidden = true,
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
        },
        vimgrep_arguments = {
          'rg',
          '--with-filename',
          '--column',
          '--line-number',
          '--smart-case',
          '--no-heading',
          '--hidden',
          '--no-binary',
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
    }
  end,
}
