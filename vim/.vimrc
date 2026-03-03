if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    \ >/dev/null 2>&1
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' } 
call plug#end()

" Apperarance
syntax enable
colorscheme catppuccin_mocha

" Options
set ts=2
set sw=2
set sts=2
set et
set smartindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
set ambiwidth=double

let g:NERDTreeShowHidden=1
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapJumpParent='h'
let g:ctrlp_show_hidden=1

" Keymaps
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = ' '
nnoremap '[q' <cmd>cprevious<cr>
nnoremap ']q' <cmd>cnext<cr>
nnoremap <silent> <C-e> <cmd>NERDTreeToggle<cr>
nnoremap <leader>gs <cmd>0G<cr>
nnoremap <leader>gd <cmd>Gdiff<cr>
