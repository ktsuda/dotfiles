return {
  'williamboman/mason-lspconfig.nvim',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'folke/lazydev.nvim',
  },
  config = function()
    local utils = require('utils.custom-lspconfig')
    local mason_lspc = require('mason-lspconfig')
    mason_lspc.setup({
      automatic_installation = true,
      ensure_installed = vim.tbl_keys(utils.server_configs),
    })
    for server_name, config in pairs(utils.server_configs) do
      local updated_config = vim.tbl_deep_extend('force', config or {}, {
        capabilities = utils.capabilities,
        on_attach = utils.on_attach,
        on_init = utils.on_init,
      })
      -- vim.lsp.config(server_name, updated_config)
      require('lspconfig')[server_name].setup(updated_config)
    end
  end,
}
