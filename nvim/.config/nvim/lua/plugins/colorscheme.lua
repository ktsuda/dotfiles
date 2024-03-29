return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm', -- storm, moon, or night
      light_style = 'day',
      transparent = true,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd([[ colorscheme tokyonight]])
    end,
  },
}
