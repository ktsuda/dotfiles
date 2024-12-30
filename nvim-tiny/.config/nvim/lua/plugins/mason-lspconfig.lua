local utils = require('utils.custom-lspconfig')

return {
  'williamboman/mason-lspconfig.nvim',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'folke/lazydev.nvim',
  },
  config = function()
    local mason_lspc = require('mason-lspconfig')
    mason_lspc.setup({
      automatic_installation = true,
      ensure_installed = vim.tbl_keys(utils.server_configs),
    })
    local lspconfig = require('lspconfig')
    mason_lspc.setup_handlers({
      function(server_name)
        local config = vim.tbl_deep_extend('force', utils.server_configs[server_name] or {}, {
          capabilities = utils.capabilities,
          on_attach = utils.on_attach,
          on_init = utils.on_init,
        })
        lspconfig[server_name].setup(config)
      end,
    })
  end,
}
