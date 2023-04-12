local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then
  return
end

lualine.setup({
  options = {
    theme = 'gruvbox_dark',
    icons_enabled = true,
  },
  sections = {
    lualine_b = {
      { 'branch' },
    },
    lualine_c = {
      {
        'diff',
        colored = true,
        diff_color = {
          added = 'DiffAdd',
          modified = 'DiffChange',
          removed = 'DiffDelete',
        },
      },
      { 'diagnostics' },
      { 'filename' },
    },
  },
  extensions = {
    'quickfix',
    'fugitive',
    'nvim-tree',
    'fzf',
  },
})
