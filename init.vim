set nocompatible

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'francoiscabrol/ranger.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'

call plug#end()

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set textwidth=0
set wrapmargin=0
autocmd BufLeave,FocusLost * silent! wall
colorscheme solarized

" Syntastic configuration for jshint and jscs
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 0
autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc', '.;') != '' ? ['jscs', 'jshint'] : ['jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '☡'
let g:syntastic_style_warning_symbol = '¡'
let g:syntastic_enable_balloons = 1

let g:ctrlp_show_hidden = 1

" user defined functions
fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()

" toggles
noremap <Leader>tp :set invpaste paste?<cr>
noremap <Leader>tn :set invnumber number?<cr>
" files
noremap <Leader>ff :CtrlP<cr>
noremap <Leader>fs :w<cr>
"noremap <Leader>fr :Ranger<cr> "doesn't work in macvim
noremap <Leader>ft :NERDTree<cr>
" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>
" NERDCommenter commands
" vim
noremap <Leader>vr :source ~/.vimrc<cr>
noremap <Leader>ve :edit ~/.vimrc<cr>
" vim plug
noremap <Leader>vpi :PlugInstall<cr>
noremap <Leader>vpu :PlugUpdate<cr>
noremap <Leader>vpc :PlugClean<cr>
" windows
noremap <Leader>wc <C-w>c
noremap <Leader>ws <C-w>s
noremap <Leader>ww <C-w>w
noremap <Leader>wq <C-w>q
noremap <Leader>wv <C-w>v
noremap <Leader>wo <C-w>o
noremap <Leader>wh <C-w>h
noremap <Leader>wj <C-w>j
noremap <Leader>wk <C-w>k
noremap <Leader>wl <C-w>l
noremap <Leader>w> 10<C-w>>
noremap <Leader>w< 10<C-w><
noremap <Leader>w- 10<C-w>-
noremap <Leader>w+ 10<C-w>+
noremap <Leader>w= 10<C-w>=
noremap <Leader>w\| <C-w>\|
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

