return {
  'VonHeikemen/fine-cmdline.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  cmd = 'FineCmdline',
  keys = {
    { ':', '<cmd>FineCmdline<cr>', mode = 'n', { noremap = true }, desc = 'Cmdline' },
    { ':', ':<C-u>FineCmdline<cr>', mode = 'v', { noremap = true }, desc = 'Cmdline' },
  },
  opts = {},
}
