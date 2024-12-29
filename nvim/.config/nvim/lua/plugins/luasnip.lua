return {
  'L3MON4D3/LuaSnip',
  enabled = true,
  lazy = true,
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  opts = {
    history = true,
    delete_check_events = 'TextChanged',
  },
  config = function(_, opts)
    local luasnip = require('luasnip')
    luasnip.setup(opts)
    luasnip.config.setup()
    require('luasnip.loaders.from_vscode').lazy_load({
      exclude = vim.g.vscode_snippets_exclude or {},
    })

    vim.api.nvim_create_autocmd('InsertLeave', {
      callback = function()
        if
          require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
        then
          require('luasnip').unlink_current()
        end
      end,
    })
  end,
}
