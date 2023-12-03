return {
  {
    'numToStr/FTerm.nvim',
    keys = {
      {
        '<leader>tt',
        '<cmd>lua require("FTerm").toggle()<cr>',
        mode = 'n',
        desc = '[t]oggle [t]erminal',
      },
      {
        '<leader>tt',
        '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>',
        mode = 't',
        desc = '[t]oggle [t]erminal',
      },
      { '<leader>ta', '<cmd>FTermTigAll<cr>', desc = '[t]ig [a]ll' },
      { '<leader>ts', '<cmd>FTermTigStatus<cr>', desc = '[t]ig [s]tatus' },
      { '<leader>tl', '<cmd>FTermGitLogP %<cr>', desc = '[t]ig [l]og' },
    },
    cmd = { 'FTermTigAll', 'FTermTigStatus', 'FTermGitLogP' },
    opts = {
      border = 'single',
      blend = 20,
      dimensions = {
        height = 0.5,
        width = 1.0,
        x = 0.5,
        y = 1.0,
      },
    },
    config = function(_, opts)
      local fterm = require('FTerm')
      fterm.setup(opts)
      local border = opts.border or 'double'
      local dimensions = opts.dimensions or {}
      vim.api.nvim_create_user_command('FTermTigAll', function()
        fterm
          :new({
            cmd = 'tig --all',
            border = border,
            dimensions = dimensions,
          })
          :toggle()
      end, { bang = true })
      vim.api.nvim_create_user_command('FTermTigStatus', function()
        fterm
          :new({
            cmd = 'tig status',
            border = border,
            dimensions = dimensions,
          })
          :toggle()
      end, { bang = true })
      vim.api.nvim_create_user_command('FTermGitLogP', function(path)
        fterm
          :new({
            cmd = 'tig ' .. vim.fn.expand(path.args),
            border = border,
            dimensions = dimensions,
          })
          :toggle()
      end, { bang = true, nargs = '?' })
    end,
  },
}
