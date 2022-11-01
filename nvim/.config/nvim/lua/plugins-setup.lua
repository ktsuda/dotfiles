-- Install packer
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

-- Load the config file every time when it's saved
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/.config/nvim/lua/plugins-setup.lua',
  callback = function()
    local readable = vim.api.nvim_exec('source <afile>', true)
    if readable then
      vim.api.nvim_command('PackerSync')
    end
  end,
  group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
})

-- plugins
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
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-nvim-lsp')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('rafamadriz/friendly-snippets')
  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable('make') == 1,
  })
  use('nvim-telescope/telescope-project.nvim')
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')
  use('akinsho/bufferline.nvim')
  use('nvim-lualine/lualine.nvim')
  use('christoomey/vim-tmux-navigator')
  use('szw/vim-maximizer')
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
