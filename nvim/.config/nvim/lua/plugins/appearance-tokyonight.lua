return {
  'folke/tokyonight.nvim',
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    style = 'storm', -- storm, moon, or night
    light_style = 'day',
    transparent = true,
    styles = {
      sidebars = 'transparent',
      floats = 'transparent',
    },
  },
  config = function(_, opts)
    vim.opt.background = 'dark'
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme('tokyonight')
  end,
}
