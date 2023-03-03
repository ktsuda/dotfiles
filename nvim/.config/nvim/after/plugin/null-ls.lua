local null_ls_status, null_ls = pcall(require, 'null-ls')
if not null_ls_status then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
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
    extra_args = {
      '--no-semi',
      '--single-quote',
      '--jsx-single-quote',
    },
  }),
  formatting.clang_format,
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
  formatting.black,
  formatting.trim_whitespace,
}

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end, { buffer = bufnr })
end

null_ls.setup({
  sources = sources,
  on_attach = on_attach,
})
