-- Install packer
local ensure_packer = function()
  local install_path = vim.fn.stdpath('data')
    .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })

    vim.api.nvim_command('packadd packer.nvim')

    return true
  else
    return false
  end
end

local packer_bootstrap = ensure_packer()

local packer_status, packer = pcall(require, 'packer')
if not packer_status then
  return
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/.config/nvim/lua/local/packer.lua',
  callback = function()
    local readable = vim.api.nvim_exec('source <afile>', true)

    if readable then
      packer.sync()
    end
  end,
  group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
})

-- plugins
packer.startup(function(use)
  use('wbthomason/packer.nvim')
  -- git
  use({
    {
      'ktsuda/vim-fugitive',
      branch = 'signoff',
      lock = true,
      config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git, {})
        vim.keymap.set('n', '<leader>gd', vim.cmd.Gdiff, {})
      end,
    },
    { 'lewis6991/gitsigns.nvim' },
  })
  -- colorscheme
  use({
    {
      'ellisonleao/gruvbox.nvim',
      config = function()
        vim.cmd.colorscheme('gruvbox')
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        pcall(require('nvim-treesitter.install').update({ with_sync = true }))
      end,
    },
  })
  -- fuzzy finder
  use({
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      lock = true,
      requires = { 'nvim-lua/plenary.nvim' },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'jvgrootveld/telescope-zoxide' },
  })
  -- lsp
  use({
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'rafamadriz/friendly-snippets' },
    { 'jose-elias-alvarez/null-ls.nvim' },
  })
  -- decoration
  use({
    { 'kyazdani42/nvim-web-devicons' },
    { 'kyazdani42/nvim-tree.lua' },
    { 'akinsho/bufferline.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    {
      'fladson/vim-kitty',
      ft = { 'kitty' },
    },
    {
      'kovetskiy/sxhkd-vim',
      ft = { 'sxhkd' },
    },
  })
  -- utilities
  use({
    { 'tpope/vim-surround' },
    { 'windwp/nvim-autopairs' },
    { 'mbbill/undotree' },
    {
      'voldikss/vim-floaterm',
      config = function()
        vim.keymap.set('n', '<leader>tt', vim.cmd.FloatermToggle, {})
        vim.keymap.set('t', '<leader>tt', '<C-\\><C-n>:FloatermToggle<CR>', {})
        vim.keymap.set('n', '<leader>tf', ':FloatermNew FZF_DEFAULT_COMMAND=\'fdfind --hidden --exclude .git\' fzf<CR>', {})
        vim.keymap.set('n', '<leader>ts', ':FloatermNew tig status<CR>', {})
        vim.keymap.set('n', '<leader>gl', ':FloatermNew --height=1.0 tig %<CR>', {})
      end,
    },
    {
      'dhruvasagar/vim-table-mode',
      ft = { 'markdown' },
      config = function()
        vim.g.table_mode_corner = '|'
      end,
    },
    {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.keymap.set('n', '<leader>mp', vim.cmd.MarkdownPreview, {})
      end,
      ft = { 'markdown' },
      cond = vim.fn.executable('npm') == 1,
    },
  })
  -- input method
  use({
    { 'vim-denops/denops.vim' },
    {
      'vim-skk/skkeleton',
      config = function()
        vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })
        vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })
        vim.cmd [[
          call skkeleton#config({
            \   'eggLikeNewline': v:true,
            \   'globalJisyo': expand('~/.cache/skk/SKK-JISYO.L'),
            \ })
        ]]
      end,
    },
  })
  -- time tracker
  use('wakatime/vim-wakatime')

  if packer_bootstrap then
    packer.sync()
  end
end)

if packer_bootstrap then
  print('Installing plugins...')
  print('Restart neovim after the paker process completes.')
  return
end
