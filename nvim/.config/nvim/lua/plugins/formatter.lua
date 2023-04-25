return {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        {
            'williamboman/mason.nvim',
            cmd = 'Mason',
            opts = {},
        },
        {
            'jay-babu/mason-null-ls.nvim',
            opts = {
                ensure_installed = {
                    'prettierd',
                    'clang-format',
                    'shfmt',
                    'stylua',
                    'black',
                    'gofmt',
                    'goimports',
                },
                automatic_installation = false,
                automatic_setup = false,
            },
        },
    },
    opts = function()
        local null_ls = require('null-ls')
        local formatting = null_ls.builtins.formatting
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
                    4,
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
                    4,
                },
            }),
            formatting.black,
            formatting.gofmt,
            formatting.goimports,
            formatting.trim_whitespace,
        }
        local on_attach = function(_, bufnr)
            vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format({ timeout_ms = 2000 })
            end, { buffer = bufnr })
        end
        return {
            sources = sources,
            on_attach = on_attach,
        }
    end,
}
