local utils = require('utils.custom-telescope')

return {
  'nvim-telescope/telescope-live-grep-args.nvim',
  version = '^1.0.0',
  enabled = true,
  keys = {
    {
      '<leader>fa',
      utils.extension('live_grep_args', 'live_grep_args'),
      desc = 'Telescope: Search string by grep args',
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
    local lga_actions = require('telescope-live-grep-args.actions')
    telescope.setup({
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ['<C-r>'] = lga_actions.to_fuzzy_refine,
            },
          },
        },
      },
    })
    pcall(telescope.load_extension, 'live_grep_args')
  end,
}
