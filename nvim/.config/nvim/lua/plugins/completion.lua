return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = function()
      local cmp = require('cmp')
      local custom_cmp = require('utils.completion')
      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
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
            select = true,
          }),
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
      }
    end,
  },
  {
    'hrsh7th/cmp-buffer',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
  {
    'hrsh7th/cmp-cmdline',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
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
  {
    'hrsh7th/cmp-path',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'path' },
        },
      })
    end,
  },
  {
    'onsails/lspkind-nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
          }),
        },
      })
    end,
  },
  {
    'hrsh7th/cmp-nvim-lua',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'nvim_lua' },
        },
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    config = function(_, opts)
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup(opts)
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
      })
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'luasnip' },
        },
      })
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
      })
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
