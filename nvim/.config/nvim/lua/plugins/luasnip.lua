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
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
