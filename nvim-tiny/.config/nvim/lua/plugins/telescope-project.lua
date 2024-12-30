return {
  'nvim-telescope/telescope-project.nvim',
  enabled = true,
  keys = {
    {
      '<C-s>',
      function()
        require('telescope').extensions.project.project()
      end,
      desc = 'search repos',
    },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local telescope_status, telescope = pcall(require, 'telescope')
    if not telescope_status then
      return
    end
    telescope.setup({
      extensions = {
        project = {
          base_dirs = {
            { path = vim.env.HOME .. '/src', max_depth = 5 },
            { path = (vim.env.GOPATH or (vim.env.HOME .. '/go')) .. '/src', max_depth = 4 },
            { path = vim.env.HOME .. '/Projects', max_depth = 4 },
          },
          hidden_files = true,
        },
      },
    })
    pcall(telescope.load_extension, 'project')
  end,
}
