return {
  'nvim-telescope/telescope-fzf-native.nvim',
  enabled = true,
  build = 'make',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  cond = function()
    return vim.fn.executable('make') == 1
  end,
  config = function()
    local telescope_status, telescope = pcall(require, 'telescope')
    if not telescope_status then
      return
    end
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })
    pcall(telescope.load_extension, 'fzf')
  end,
}

