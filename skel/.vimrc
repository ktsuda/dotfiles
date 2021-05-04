" vim: set et ts=4 sw=4 sts=4:

if &compatible
    set nocompatible
endif

let mapleader = "\<Space>"

" language =====================================================================
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

" misc =========================================================================
let g:vim_indent_cont = 4
set relativenumber
set number
set guicursor=
set smartindent
set backspace=indent,eol,start
set hlsearch
set laststatus=2
set statusline=%f%m%h%w%<(%Y)[%{&fenc!=''?&fenc:&enc}:%{&ff}]%=%l/%L(%02v)
set modeline
set modelines=5
set hidden
set incsearch
set smartcase
set showmode
set showmatch
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

set scrolloff=8
set list
set listchars=tab:»-,trail:-
set nowrap
set nomousehide
set noswapfile
let loaded_matchparen=1

" package manager ==============================================================
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'kana/vim-operator-user'
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'preservim/tagbar'
Plug 'thinca/vim-quickrun'
Plug 'editorconfig/editorconfig-vim'
Plug 'wakatime/vim-wakatime'
Plug 'tyru/skk.vim'
call plug#end()

augroup install_plugins
    autocmd!
    autocmd VimEnter *
        \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \ |   PlugInstall --sync | q
        \ | endif
augroup END

filetype plugin indent on
syntax enable

" gruvbox ======================================================================
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" gitgutter ====================================================================
set updatetime=250

" fzf.vim ======================================================================
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '40%' }
let g:fzf_commits_log_options =
    \ '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <silent> <C-p> :GFiles<CR>

" nerdtree =====================================================================
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" lsp ==========================================================================
nmap <silent> <leader>gd :LspDefinition<CR>
nmap <silent> <leader>rn :LspRename<CR>
nmap <silent> <Leader>gt :LspTypeDefinition<CR>
nmap <silent> <Leader>gr :LspReferences<CR>
nmap <silent> <Leader>gi :LspImplementation<CR>
nmap <silent> <Leader>gh :LspHover<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

augroup lsp_format
    autocmd!
    autocmd BufWritePre *.(py|cpp|c|h) LspDocumentFormatSync
augroup END

" a.vim ========================================================================
nmap <silent> <leader>aa :A<CR>
nmap <silent> <leader>at :AT<CR>
nmap <silent> <leader>av :AV<CR>

" editorconfig-vim =============================================================
let g:EditorConfig_exclude_patterns = [
    \ 'fugitive://.*',
    \ 'scp://.*'
    \ ]
augroup editor_config
    autocmd!
    autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END

" skk.vim ======================================================================
let skk_large_jisyo='~/.skk/dict/SKK-JISYO.L'
let g:skk_auto_save_jisyo = 1
set imdisable

" quickfix =====================================================================
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap 'q :cclose<CR>

" tab ==========================================================================
nnoremap <silent>tt :<C-u>tabe<CR>
nnoremap <silent>th :<C-u>tabp<CR>
nnoremap <silent>tl :<C-u>tabn<CR>

" clipboard ====================================================================
if has('mac') || has('win64') || has('win32')
    set clipboard^=unnamed
else
    set clipboard^=unnamedplus
endif

" spacing ======================================================================
augroup filetype_tab
    autocmd!
    autocmd FileType ruby,yaml,json,c,cpp,zsh setlocal ts=2 sw=2 sts=2 et
    autocmd FileType markdown,html,css,python setlocal ts=4 sw=4 sts=4 et
    autocmd FileType go setlocal ts=4 sw=4 sts=4 noet
augroup END

" config file ==================================================================
nnoremap <leader>. :so $MYVIMRC<CR>
nnoremap <leader>, :e $MYVIMRC<CR>

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" never load plugins when you commit
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
    finish
end
