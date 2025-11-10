vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope-project.nvim' },
})

local t_status, t = pcall(require, 'telescope')
if not t_status then
  return
end

t.setup({
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

pcall(t.load_extension, 'project')

vim.keymap.set('n', '<C-s>', function()
  t.extensions.project.project({
    display_type = 'full',
  })
end, { desc = 'Search repos' })
