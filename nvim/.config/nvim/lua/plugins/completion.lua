return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      {
        'hrsh7th/cmp-cmdline',
        config = function()
          local cmp = require('cmp')
          cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' },
            },
          })
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' },
            }, {
              {
                name = 'cmdline',
                option = {
                  ignore_cmds = { 'Man', '!' },
                },
              },
            }),
          })
        end,
      },
      { 'hrsh7th/cmp-nvim-lua' },
      {
        'L3MON4D3/LuaSnip',
        opts = {
          history = true,
          delete_check_events = 'TextChanged',
        },
        config = function()
          require('luasnip').config.setup()
        end,
      },
      { 'saadparwaiz1/cmp_luasnip' },
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      { 'onsails/lspkind-nvim' },
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')
      local custom_cmp = require('utils.completion')
      return {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        mapping = {
          ['<C-n>'] = cmp.mapping(custom_cmp.next_expand_jump, { 'i', 's' }),
          ['<C-p>'] = cmp.mapping(custom_cmp.prev_expand_jump, { 'i', 's' }),
          ['<C-g>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping(custom_cmp.complete_common, { 'i', 's' }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.sort_text,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
          }),
        },
      }
    end,
  },
}
