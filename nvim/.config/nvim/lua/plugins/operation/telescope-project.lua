local t_status, t = pcall(require, 'telescope')
if not t_status then
  return
end

local function load()
  vim.pack.add({
    { src = 'https://github.com/nvim-telescope/telescope-project.nvim' },
  })

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
end

vim.keymap.set('n', '<C-s>', function()
  load()
  t.extensions.project.project({
    display_type = 'full',
    hide_workspace = true,
  })
end, { desc = 'Search repos' })
