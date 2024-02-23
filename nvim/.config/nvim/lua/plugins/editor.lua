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
    'numToStr/Comment.nvim',
    keys = {
      { '<leader>cc', '<Plug>(comment_toggle_linewise)', mode = { 'v' }, desc = '[c]omment [c]urrent line' },
      { '<leader>cb', '<Plug>(comment_toggle_blockwise)', mode = { 'v' }, desc = '[c]omment [b]lockwise' },
      { '<leader>cc', '<Plug>(comment_toggle_linewise_current)', mode = { 'n' }, desc = '[c]omment [c]urrent line' },
      { '<leader>cb', '<Plug>(comment_toggle_blockwise_current)', mode = { 'n' }, desc = '[c]omment [b]lockwise' },
    },
    opts = {
      padding = true,
      sticky = true,
      ignore = '^$',
      toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      opleader = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      mappings = {
        basic = true,
        extra = false,
      },
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
}
