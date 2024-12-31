return {
  'aaronhallaert/advanced-git-search.nvim',
  enabled = false,
  -- keymaps: https://github.com/aaronhallaert/advanced-git-search.nvim?tab=readme-ov-file#keymaps-1
  keys = {
    { '<leader>gl', '<cmd>Telescope advanced_git_search diff_commit_file<cr>', desc = '[g]it [l]og' },
    { '<leader>gf', '<cmd>Telescope advanced_git_search search_log_content_file<cr>', desc = '[g]it [f]ile' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'ktsuda/vim-fugitive',
  },
  config = function()
    local telescope_status, telescope = pcall(require, 'telescope')
    if not telescope_status then
      return
    end
    telescope.setup({
      extensions = {
        advanced_git_search = {
          diff_plugin = 'fugitive',
          entry_default_author_or_date = 'author',
          telescope_theme = {
            show_custom_functions = {
              layout_config = { width = 0.4, height = 0.4 },
            },
          },
        },
      },
    })
    pcall(telescope.load_extension, 'advanced_git_search')
  end,
}
