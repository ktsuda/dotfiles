return {
    {
        'numToStr/FTerm.nvim',
        keys = {
            {
                '<leader>tt',
                '<cmd>lua require("FTerm").toggle()<cr>',
                mode = 'n',
                desc = 'terminal',
            },
            {
                '<leader>tt',
                '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>',
                mode = 't',
                desc = 'terminal',
            },
            { '<leader>ts', '<cmd>FTermTigStatus<cr>', desc = 'tig status' },
            { '<leader>gl', '<cmd>FTermGitLogP %<cr>', desc = 'git log -p' },
        },
        cmd = { 'FTermTigStatus', 'FTermGitLogP' },
        opts = {
            border = 'double',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        },
        config = function(_, opts)
            local fterm = require('FTerm')
            fterm.setup(opts)
            local border = opts.border or 'double'
            local dimensions = opts.dimensions or {}
            vim.api.nvim_create_user_command('FTermTigStatus', function()
              fterm:new({
                cmd = 'tig status',
                border = border,
                dimensions = dimensions,
              }):toggle()
            end, { bang = true })
            vim.api.nvim_create_user_command('FTermGitLogP', function(path)
              fterm:new({
                cmd = 'tig ' .. vim.fn.expand(path.args),
                border = border,
                dimensions = dimensions,
              }):toggle()
            end, { bang = true, nargs = '?' })
        end,
    },
}
