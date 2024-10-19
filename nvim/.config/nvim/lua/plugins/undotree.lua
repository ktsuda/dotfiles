return {
  'mbbill/undotree',
  enabled = false,
  keys = {
    { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Undotree' },
  },
  dependencies = {
    'hrsh7th/nvim-cmp',
    'windwp/nvim-autopairs',
  },
  opts = {},
  config = function(_, opts)
    local ap_status, ap = pcall(require, 'nvim-autopairs')
    local cmp_status, cmp = pcall(require, 'cmp')
    if not ap_status or not cmp_status then
      return
    end
    ap.setup(opts)
    local cmp_ap = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_ap.on_confirm_done())
  end,
}
