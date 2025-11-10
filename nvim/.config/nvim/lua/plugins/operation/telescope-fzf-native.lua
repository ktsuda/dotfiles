vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
})

local t_status, t = pcall(require, 'telescope')
if not t_status then
  return
end

t.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

pcall(t.load_extension, 'fzf')
