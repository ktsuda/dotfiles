return {
  'Tsuzat/NeoSolarized.nvim',
  enable = true,
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
}
