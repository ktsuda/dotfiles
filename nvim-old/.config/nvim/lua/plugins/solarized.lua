return {
  {
    'Tsuzat/NeoSolarized.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('NeoSolarized').setup({
        style = 'dark',
        terminal_colors = true,
        enable_italic = false,
      })
      vim.cmd.colorscheme('NeoSolarized')
    end,
  },
  {
    'maxmx03/solarized.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      require('solarized').setup()
      vim.cmd.colorscheme('solarized')
    end,
  },
  {
    'lifepillar/vim-solarized8',
    branch = 'neovim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme('solarized8_flat')
    end,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      sidebars = { 'qf', 'help', 'terminal', 'packer' },
      styles = {
        sidebars = 'normal', -- no effect?
        floats = 'normal', -- no effect?
      },
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme('solarized-osaka')
      require('solarized-osaka').setup(opts)
    end,
  },
}
