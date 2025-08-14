local utils = require('utils.custom-telescope')

return {
    'nvim-telescope/telescope.nvim',
    enable = true,
    event = 'VeryLazy',
    tag = '0.1.8',
    branch = '0.1.x',
    keys = {
        { '<C-p>', utils.custom('files'), desc = 'Telescope: Search files' },
        { '<leader>fg', utils.custom('grep'), desc = 'Telescope: Search string by grep' },
        { '<leader>fk', utils.custom('keymaps'), desc = 'Telescope: Search keymaps' },
        { '<leader>fb', utils.custom('buffers'), desc = 'Telescope: Search buffers' },
        { '<leader>/', utils.custom('string'), desc = 'Telescope: Search in current buffer' },
        { '<leader>fh', utils.custom('help_tags'), desc = 'Telescope: Search helptags' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = function()
        local ta = require('telescope.actions')
        return {
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
                        ['<C-k>'] = ta.preview_scrolling_up,
                        ['<C-j>'] = ta.preview_scrolling_down,
                        ['<C-u>'] = ta.results_scrolling_up,
                        ['<C-d>'] = ta.results_scrolling_down,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true, -- for find_files
                },
            },
        }
    end,
}
