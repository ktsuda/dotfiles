local utils = require('utils.custom-telescope')

return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  event = 'VeryLazy',
  tag = '0.1.8',
  branch = '0.1.x',
  keys = {
    { '<C-p>', utils.custom('files'), desc = 'Telescope: Search files' },
    { '<leader>sf', utils.custom('files'), desc = 'Telescope: Search files' },
    { '<leader>sg', utils.custom('grep'), desc = 'Telescope: Search string by grep' },
    { '<leader>sk', utils.custom('keymaps'), desc = 'Telescope: Search keymaps' },
    { '<leader>sb', utils.custom('buffers'), desc = 'Telescope: Search buffers' },
    { '<leader>gb', utils.custom('git_branches'), desc = 'Telescope: Git branch' },
    { '<leader>/', utils.custom('string'), desc = 'Telescope: Search in current buffer' },
    { '<leader>sh', utils.custom('help_tags'), desc = 'Telescope: Search helptags' },
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
