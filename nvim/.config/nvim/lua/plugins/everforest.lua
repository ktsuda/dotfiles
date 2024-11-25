return {
  'neanias/everforest-nvim',
  enable = true,
  lazy = false,
  priority = 1000,
  opts = {
    background = 'medium',
    transparent_background_level = 2,
    italics = false,
    disable_italic_comments = true,
    sign_column_background = 'high',
    ui_contrast = 'high',
    float_style = 'dim',
  },
  config = function(_, opts)
    local everforest = require('everforest')
    everforest.setup(opts)
    everforest.load()
  end,
}
