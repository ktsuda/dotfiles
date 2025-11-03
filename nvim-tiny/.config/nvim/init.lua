-- vim: set ts=2 sw=2 sts=2 et:
require('core.options')
require('core.keymaps')

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/Saghen/blink.cmp' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.8' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
    -- formatters
    'stylua',
    'prettierd',
    'shfmt',
    'beautysh',
    -- language servers
    'lua_ls',
    'clangd',
    'ts_ls',
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
    telemetry = { enable = false },
  },
})

vim.lsp.config('clangd', {
  cmd = {
    -- see clangd --help-hidden
    'clangd',
    '--background-index',
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    '--clang-tidy',
    '--completion-style=bundled',
    '--cross-file-rename',
    '--header-insertion=iwyu',
  },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.git' },
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
  },
  root_markers = { '.git' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

require('luasnip.loaders.from_vscode').lazy_load()

require('blink.cmp').setup({
  signature = { enabled = true },
  fuzzy = { implementation = 'lua' },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = { auto_show = true },
  },
  keymap = {
    preset = 'none',
    ['<C-Space>'] = { 'fallback' },
    ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-g>'] = { 'cancel', 'fallback' },
    -- ['<C-g>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
})

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'shfmt' },
    zsh = { 'beautysh' },
  },
  formatters = {
    prettier = {
      prepend_args = { '--no-semi', '--single-quote', '--jsx-single-quote', '--print-width=120' },
    },
    stylua = {
      prepend_args = { '--quote-style', 'AutoPreferSingle', '--indent-type', 'Spaces', '--indent-width', '2' },
    },
    shfmt = {
      args = { '-i', '4', '-ci', '-bn', '-sr', '-s' },
    },
    beautysh = {
      prepend_args = { '-i', '2', '-s', 'fnpar' },
    },
  },
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_format = 'fallback',
  -- },
})

vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ timeout_ms = 500, lsp_format = 'fallback' })
end, { desc = 'Format the current buffer' })

require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--with-filename',
      '--column',
      '--line-number',
      '--smart-case',
      '--no-heading',
      '--hidden',
      '--no-binary',
    }, -- for live grep
    mappings = {
      i = {
        ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
        ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-j>'] = require('telescope.actions').results_scrolling_down,
        ['<C-k>'] = require('telescope.actions').results_scrolling_up,
      },
    },
  },
  pickers = { find_files = { hidden = true } },
})

vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files()
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>sa', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Grep strings' })

vim.keymap.set('n', '<leader>sk', function()
  require('telescope.builtin').keymaps()
end, { desc = 'Search keymaps' })

vim.keymap.set('n', '<leader>sb', function()
  require('telescope.builtin').buffers()
end, { desc = 'Search buffers' })

vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end, { desc = 'Search current buffer' })

vim.keymap.set('n', '<leader>gl', function()
  require('telescope.builtin').git_commits({
    git_command = {
      'git',
      'log',
      '--all',
      '--date=short',
      '--pretty=oneline',
      '--format=%h %ad %cn %s %d',
    },
  })
end, { desc = 'Search current buffer' })
