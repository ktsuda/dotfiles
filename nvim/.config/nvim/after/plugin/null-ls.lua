local null_ls_status, null_ls = pcall(require, 'null-ls')
if not null_ls_status then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  -- webdev
  formatting.prettierd.with({
    filetypes = {
      'typescript',
      'typescriptreact',
      'javascriptreact',
      'graphql',
      'html',
      'css',
      'scss',
      'yaml',
      'markdown',
      'less',
      'jsonc',
      'json',
      'javascript',
      'vue',
    },
    extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
  }),
  -- markdown
  diagnostics.markdownlint,
  -- c/c++
  formatting.clang_format,
  -- sh
  formatting.shfmt.with({
    extra_args = {
      '-i',
      2,
      '-ci',
      '-bn',
      '-sr',
      '-s',
    },
  }),
  -- lua
  formatting.stylua.with({
    extra_args = {
      '--quote-style',
      'AutoPreferSingle',
      '--indent-type',
      'Spaces',
      '--indent-width',
      2,
    },
  }),
  -- python
  formatting.black,
  -- common
  formatting.trim_whitespace,
}

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end, bufopts)
end

null_ls.setup({
  sources = sources,
  on_attach = on_attach,
})
