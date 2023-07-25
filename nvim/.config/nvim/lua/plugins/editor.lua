return {
  {
    'tpope/vim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    ft = { 'typescript', 'typescriptreact' },
    opts = {},
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Undotree' },
    },
    opts = {},
    config = function(_, opts)
      local ap = require('nvim-autopairs')
      ap.setup(opts)
      local cmp_status, cmp = pcall(require, 'cmp')
      if not cmp_status then
        return
      end
      local cmp_ap = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_ap.on_confirm_done())
    end,
  },
  {
    'wakatime/vim-wakatime',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}
