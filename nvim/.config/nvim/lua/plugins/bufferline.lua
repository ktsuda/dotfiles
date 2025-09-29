return {
  'akinsho/bufferline.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    local bufferline = require('bufferline')
    vim.opt.termguicolors = true
    bufferline.setup({
      options = {
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        diagnostics = 'nvim_lsp',
        diagnostics_update_on_event = true,
        color_icons = false,
        separator_style = { '', '' },
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
            separator = false,
          },
        },
      },
    })
  end,
}
