vim.pack.add({
  {
    src = 'https://github.com/L3MON4D3/LuaSnip',
    name = 'luasnip',
    version = 'v2.4.1',
    data = {
      on_changed = function(event)
        local name, kind, path = event.data.spec.name, event.data.kind, event.data.path

        if name == 'luasnip' and (kind == 'install' or kind == 'update') then
          vim.system({ 'make', 'install_jsregexp' }, { cwd = path })
        end
      end,
    },
  },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/Saghen/blink.cmp' },
})

require('luasnip.loaders.from_vscode').lazy_load()

require('blink.cmp').setup({
  signature = { enabled = true },
  fuzzy = { implementation = 'lua' },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind' },
        },
      },
    },
  },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
    },
  },
  keymap = {
    preset = 'none',
    ['<C-Space>'] = { 'fallback' },
    ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-g>'] = { 'cancel', 'fallback' },
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
