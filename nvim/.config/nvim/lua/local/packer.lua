-- Install packer
local ensure_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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

-- Load the config file every time when it's saved
local packer_status, packer = pcall(require, 'packer')
if not packer_status then
  return
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/.config/nvim/lua/local/packer.lua',
  callback = function()
    local command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile'
    local readable = vim.api.nvim_exec(command, true)
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
    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
  })
  -- colorscheme
  use({
    {
      'overcache/neosolarized',
      config = function()
        vim.g.neosolarized_underline = 0
        vim.cmd.colorscheme('NeoSolarized')
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        pcall(require, 'nvim-treesitter.install').update({
	      with_sync = true,
	    })
      end,
    },
  })
  -- fuzzy finder
  use({
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = { 'nvim-lua/plenary.nvim' },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    { 'nvim-telescope/telescope-project.nvim' },
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
    { 'fladson/vim-kitty' },
    { 'kovetskiy/sxhkd-vim'},
  })
  -- utilities
  use({
    { 'tpope/vim-surround' },
    { 'windwp/nvim-autopairs' },
    { 'mbbill/undotree' },
    { 'dhruvasagar/vim-table-mode' },
    {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
      cond = vim.fn.executable('npm') == 1,
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
