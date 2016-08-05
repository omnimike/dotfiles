set nocompatible

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<
let g:ranger_map_keys = 0

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-expand-region'
Plug 'Valloric/YouCompleteMe'
"Plug 'SirVer/ultisnips'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'airblade/vim-rooter'

call plug#end()

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set textwidth=0
set wrapmargin=0
set autoread
autocmd BufLeave,FocusLost * silent! wall
syntax enable
set background=light
colorscheme solarized
set directory=$HOME/.vim/swapfiles//

" Syntastic configuration for jshint and jscs
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 0
autocmd FileType javascript let b:syntastic_checkers =
    \ findfile('.jscsrc', '.;') != '' ? ['jscs', 'jshint'] : ['jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '☡'
let g:syntastic_style_warning_symbol = '¡'
let g:syntastic_enable_balloons = 1

let NERDTreeMapOpenInTab='\r'

" user defined functions
fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()

" quit
noremap <Leader>q :q<cr>
" toggles
noremap <Leader>tp :set invpaste paste?<cr>
noremap <Leader>tn :set invnumber number?<cr>
noremap <Leader>ts :syntax enable<cr>
noremap <Leader>td :set background=dark<cr>
noremap <Leader>tl :set background=light<cr>
" files
noremap <Leader>s :w<cr>
noremap <Leader>fo :e 
noremap <Leader>ff :FZF<cr>
noremap <Leader>fr :edit<cr>
noremap <Leader>fs :Ag<cr>
noremap <Leader>ft :NERDTreeFind<cr>
noremap <Leader>fd :Ranger<cr>
" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>
noremap <Leader>cs :SyntasticCheck<cr>
" NERDCommenter commands
" vim
noremap <Leader>vr :source $MYVIMRC<cr>
noremap <Leader>ve :tabedit $MYVIMRC<cr>
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
noremap <Leader>w. 10<C-w>>
noremap <Leader>w, 10<C-w><
noremap <Leader>w- 10<C-w>-
noremap <Leader>w+ 10<C-w>+
noremap <Leader>w= 10<C-w>=
noremap <Leader>w\| <C-w>\|
noremap <Leader>wn :tabnext<cr>
noremap <Leader>wp :tabprevious<cr>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-n> :tabnext<cr>
noremap <C-p> :tabprevious<cr>
" projects
noremap <Leader>pd :tabedit ~/vg/code<cr>

