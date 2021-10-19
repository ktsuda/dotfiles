local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system(
    {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}
  )
end

vim.cmd 'packadd packer.nvim'

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use {
    'gruvbox-community/gruvbox',
    config = function()
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbo_invert_selection = '0'
    end
  }
  use {
    'preservim/nerdtree',
    config = function()
      vim.api.nvim_set_var('NERDTreeShowHidden', 1)
    end
  }
  use {
    'junegunn/fzf',
    run = fn['fzf#install'],
  }
  use {
    'junegunn/fzf.vim',
    config = function()
      vim.g.fzf_buffers_jump = 1
    end
  }
  use {
    'iberianpig/tig-explorer.vim',
    requires = {
      'rbgrouleff/bclose.vim',
    }
  }
  use {
    'dhruvasagar/vim-table-mode',
    config = function()
      vim.g.table_mode_corner = '|'
    end
  }
  use {
    'iamcco/markdown-preview.nvim',
    ft = {
      'markdown'
    },
    run = 'cd app && yarn install',
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 1
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'SirVer/ultisnips',
    },
  }
  use { 'tpope/vim-surround' }
  use { 'wakatime/vim-wakatime' }
end)

vim.cmd 'autocmd BufWritePost source init.lua | PackerCompile'
