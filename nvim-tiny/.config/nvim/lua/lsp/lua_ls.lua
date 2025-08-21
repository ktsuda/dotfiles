return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
          vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
          '${3rd}/luv/library',
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'missing-fields' },
      },
    },
  },
}
