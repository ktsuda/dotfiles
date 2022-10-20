-- Configuration file for neovim
-- Author: ktsuda
-- Date: 2022-10-20
-- Install packer {{{
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.api.nvim_command('packeradd packer.nvim')
end
-- }}}
-- Load the config file every time when it's saved {{{
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/.config/nvim/init.lua',
  callback = function()
    local readable = vim.api.nvim_exec('source <afile>', true)
    if readable then
      vim.api.nvim_command('PackerSync')
    end
  end,
  group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
})
-- }}}
-- plugins {{{
local packer_status, packer = pcall(require, 'packer')
if not packer_status then return end

packer.startup(function(use)
  use('wbthomason/packer.nvim')
  use('tpope/vim-fugitive')
  use('airblade/vim-gitgutter')
  use('tpope/vim-surround')
  use('wakatime/vim-wakatime')
  use({
    'overcache/neosolarized',
    config = function()
      vim.g.neosolarized_underline = 0
    end,
  })
  use({
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' },
    },
  })
  use({
    'saadparwaiz1/cmp_luasnip',
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/nvim-cmp' },
    },
  })
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = { 'nvim-telescope/telescope.nvim' },
    cond = vim.fn.executable('make') == 1,
  })
  use({
    'nvim-telescope/telescope-project.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
  })
  use({
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })
  use({
    'akinsho/bufferline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    cond = vim.fn.executable('npm') == 1,
  })

  if is_bootstrap then
    packer.sync()
  end
end)

if is_bootstrap then
  print 'Installing plugins...'
  print 'Restart neovim after the paker process completes.'
  return
end
-- }}}
-- options {{{
vim.g.mapleader = ' '
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.laststatus = 2
vim.wo.signcolumn = 'yes'
vim.o.foldmethod = 'marker'
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.api.nvim_command('colorscheme neosolarized')
vim.o.background = 'dark'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 100

if vim.fn.has('mac') == 1 then
  vim.opt.clipboard = 'unnamed'
elseif vim.fn.has('win64') == 1 then
  vim.opt.clipboard = 'unnamed'
elseif vim.fn.has('win32') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus'
end
-- }}}
-- common keymaps {{{
vim.keymap.set('n', 'Y', 'y$', { silent = true })
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { silent = true })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { silent = true })
vim.keymap.set('n', '<C-h>', '<cmd>bprev<cr>', { silent = true })
vim.keymap.set('n', '<C-l>', '<cmd>bnext<cr>', { silent = true })
-- }}}
-- cmp {{{
local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then return end
local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then return end

cmp.setup({
  mapping = {
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-g>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({
      benavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-Space>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { 'i', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sorting = {
    comparators = {
      -- ToDo: change the sorting as you like
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
})
-- }}}
-- lsp {{{
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then return end

local on_attach = function(_, bufnr)
  vim.lsp.set_log_level('debug')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting_sync, bufopts)
  local lsp_augroup = 'LspFormat' .. bufnr
  vim.api.nvim_create_augroup(lsp_augroup, { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = lsp_augroup,
    buffer = bufnr,
    callback = function(_)
      vim.lsp.buf.formatting_sync({ timeout_ms = 3000 })
    end,
  })
end

local servers = { 'clangd', 'pyright', 'tsserver', 'sumneko_lua' }

for _, lspserver in ipairs(servers) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local lsp_flags = { debounce_text_chages = 150 }
  local lspconfig_opts = { on_attach = on_attach, flags = lsp_flags }

  if lspserver == 'clangd' then
    capabilities.offsetEncoding = { 'utf-16' }
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    }, lspconfig_opts)
  elseif lspserver == 'pyright' then
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'off',
          },
        },
      },
    }, lspconfig_opts)
  elseif lspserver == 'sumneko_lua' then
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }, lspconfig_opts)
  else
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
    }, lspconfig_opts)
  end

  lspconfig[lspserver].setup(lspconfig_opts)
end
-- }}}
-- telescope {{{
local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then return end
local telescope_actions = require('telescope.actions')
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-uu',
    },
    file_ignore_patterns = {
      '%.git/.*',
      'node_modules/.*',
      '%.DS_Store',
      '%.jpg$',
      '%.JPG$',
      '%.jpeg',
      '%.png$',
      '%.PNG$',
    },
    mappings = {
      i = {
        ['<C-u>'] = telescope_actions.preview_scrolling_up,
        ['<C-d>'] = telescope_actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    project = {
      base_dirs = {
        { path = vim.env.GHQ_ROOT, max_depth = 4 },
      },
      hidden_files = true,
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

pcall(telescope.load_extension, 'project')
pcall(telescope.load_extension, 'fzf')

local telescope_builtin = require('telescope.builtin')
local telescope_custom = {
  find_repo = function()
    telescope_builtin.find_files({
      cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
    })
  end,
  grep_repo = function()
    telescope_builtin.live_grep({
      cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
    })
  end,
  ghq_list = function()
    telescope.extensions.project.project({ display_type = 'full' })
  end,
}
vim.keymap.set('n', '<C-s>', telescope_custom.ghq_list, { silent = true })
vim.keymap.set('n', '<C-p>', telescope_custom.find_repo, { silent = true })
vim.keymap.set('n', '<leader>ug', telescope_custom.grep_repo, { silent = true })
vim.keymap.set('n', '<leader>uu', telescope_builtin.find_files, { silent = true })
vim.keymap.set('n', '<leader>uk', telescope_builtin.keymaps, { silent = true })
vim.keymap.set('n', '<leader>ub', telescope_builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>us', telescope_builtin.grep_string, { silent = true })
vim.keymap.set('n', '<leader>gc', telescope_builtin.git_commits, { silent = true })
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { silent = true })
vim.keymap.set('n', '<leader>gs', telescope_builtin.git_status, { silent = true })
vim.keymap.set('n', '<leader>gt', telescope_builtin.git_stash, { silent = true })
-- }}}
-- nvim-tree {{{
local nvim_tree_status, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_status then return end
local tree_cb = require('nvim-tree.config').nvim_tree_callback
nvim_tree.setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
        { key = '<C-e>', action = '' },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'v', cb = tree_cb('vsplit') },
        { key = 'H', action = '' },
        { key = 'I', action = 'toggle_dotfiles' },
        { key = 'H', action = 'toggle_ignored' },
        { key = 'y', action = 'copy_name' },
        { key = 'gy', action = 'copy_path' },
        { key = 'Y', action = 'copy_absolute_path' },
      },
    }
  },
  vim.keymap.set('n', '<C-e>', nvim_tree.toggle, { silent = true })
})
-- }}}
-- bufferline {{{
local bufferline_status, bufferline = pcall(require, 'bufferline')
if not bufferline_status then return end
bufferline.setup({})
-- }}}
-- lualine {{{
local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then return end
lualine.setup({
  options = {
    theme = 'solarized_dark',
    icons_enabled = false,
  },
  extensions = {
    'quickfix',
    'fugitive',
    'nvim-tree',
    'fzf',
  },
})
-- }}}
-- markdown previewer {{{
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { silent = true })
-- }}}
