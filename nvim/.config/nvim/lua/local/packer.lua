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
if not packer_status then return end

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
  use('tpope/vim-fugitive')
  use('airblade/vim-gitgutter')
  use('tpope/vim-surround')
  use('wakatime/vim-wakatime')
  use({
    'overcache/neosolarized',
    config = function()
      vim.g.neosolarized_underline = 0
      vim.cmd.colorscheme('NeoSolarized')
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
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
  use('jose-elias-alvarez/null-ls.nvim')
  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  })
  use('nvim-telescope/telescope-project.nvim')
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')
  use('windwp/nvim-autopairs')
  use('akinsho/bufferline.nvim')
  use('nvim-lualine/lualine.nvim')
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    cond = vim.fn.executable('npm') == 1,
  })
  use('dhruvasagar/vim-table-mode')
  use('fladson/vim-kitty')

  if packer_bootstrap then
    packer.sync()
  end
end)

if packer_bootstrap then
  print 'Installing plugins...'
  print 'Restart neovim after the paker process completes.'
  return
end
