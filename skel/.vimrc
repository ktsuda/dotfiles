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
set guicursor=
set smartindent
set backspace=indent,eol,start
set hlsearch
set laststatus=2

set modeline
set modelines=5
set hidden
set incsearch
set smartcase
set showmode
set showmatch
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

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
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'thinca/vim-quickrun'
Plug 'wakatime/vim-wakatime'
Plug 'tyru/skk.vim'
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'iberianpig/tig-explorer.vim'
if has('nvim')
    Plug 'rbgrouleff/bclose.vim'
endif
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

" airline ======================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap th <Plug>AirlineSelectPrevTab
nmap tl <Plug>AirlineSelectNextTab

" fzf.vim ======================================================================
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <silent> <C-p> :GFiles<CR>

if has('nvim')
    function! s:create_float(hl, opts)
        let buf = nvim_create_buf(v:false, v:true)
        let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
        let win = nvim_open_win(buf, v:true, opts)
        call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
        call setwinvar(win, '&colorcolumn', '')
        return buf
    endfunction

    function! FloatingFZF()
        " Size and position
        let width = float2nr(&columns * 0.8)
        let height = float2nr(&lines * 0.8)
        let row = float2nr((&lines - height) / 2)
        let col = float2nr((&columns - width) / 2)

        " Border
        let top = '╭' . repeat('─', width - 2) . '╮'
        let mid = '│' . repeat(' ', width - 2) . '│'
        let bot = '╰' . repeat('─', width - 2) . '╯'
        let border = [top] + repeat([mid], height - 2) + [bot]

        " Draw frame
        let s:frame = s:create_float('Comment', {'row': row, 'col': col, 'width': width, 'height': height})
        call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

        " Draw viewport
        call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
        autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
    endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
else
    let g:fzf_layout = { 'down': '40%' }
endif

" lsp ==========================================================================
nmap <silent> <leader>gd :LspDefinition<CR>
nmap <silent> <leader>rn :LspRename<CR>
nmap <silent> <leader>gt :LspTypeDefinition<CR>
nmap <silent> <leader>gr :LspReferences<CR>
nmap <silent> <leader>gi :LspImplementation<CR>
nmap <silent> <leader>gh :LspHover<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

augroup lsp_format
    autocmd!
    autocmd BufWritePre *.(py|cpp|c|h) LspDocumentFormatSync
augroup END

" skk.vim ======================================================================
let skk_large_jisyo='~/.skk/dict/SKK-JISYO.L'
let g:skk_auto_save_jisyo = 1
set imdisable

" defx =========================================================================
nnoremap <silent> <C-e> :<C-u>Defx<CR>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> defx#do_action('multi', ['drop', 'quit'])
    nnoremap <silent><buffer><expr> C defx#do_action('open')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> l
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
    nnoremap <silent><buffer><expr> e defx#do_action('preview')
    nnoremap <silent><buffer><expr> a defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> D defx#do_action('remove')
    nnoremap <silent><buffer><expr> R defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> I defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
endfunction

" ultisnips ====================================================================
" exec :UltiSnipsEdit to create a new snippet.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="horizontal"

" tig-explorer.vim =============================================================
nnoremap <leader>t :TigOpenProjectRootDir<CR>
nnoremap <leader>T :TigOpenCurrentFile<CR>
nnoremap <leader>g :TigGrep<CR>
nnoremap <leader>r :TigGrepResume<CR>
nnoremap <leader>gy :TigGrep<Space><C-R>"<CR>
nnoremap <leader>cg :<C-u>:TigGrep<Space><C-R><C-W><CR>
nnoremap <leader>b :TigBlame<CR>

" quickfix =====================================================================
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap 'q :cclose<CR>

" clipboard ====================================================================
if has('mac') || has('win64') || has('win32')
    set clipboard^=unnamed
else
    set clipboard^=unnamedplus
endif

nnoremap Y y$

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
