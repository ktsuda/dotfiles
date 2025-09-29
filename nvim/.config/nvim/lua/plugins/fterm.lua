return {
  'numToStr/FTerm.nvim',
  enabled = true,
  keys = {
    {
      '<C-y>',
      '<cmd>lua require("FTerm").toggle()<cr>',
      mode = 'n',
      desc = 'FTerm: Toggle terminal',
    },
    {
      '<C-y>',
      '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>',
      mode = 't',
      desc = 'FTerm: Toggle terminal',
    },
    { '<leader>ta', '<cmd>FTermTigAll<cr>', desc = 'FTerm: Tig all' },
    { '<leader>ts', '<cmd>FTermTigStatus<cr>', desc = 'FTerm: Tig status' },
    { '<leader>tl', '<cmd>FTermGitLogP %<cr>', desc = 'FTerm: Tig log' },
  },
  cmd = { 'FTermTigAll', 'FTermTigStatus', 'FTermGitLogP' },
  opts = {
    border = 'single',
    -- blend = 24,
    dimensions = {
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,
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
}

