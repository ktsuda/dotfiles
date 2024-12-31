return  {
  'nvchad/nvim-colorizer.lua',
  enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    user_default_options = {
      names = false,
      mode = 'background',
      tailwind = true,
      always_update = false,
    },
  },
}
