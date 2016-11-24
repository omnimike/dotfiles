set nocompatible

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-expand-region'
Plug 'amiorin/vim-project'
Plug 'terryma/vim-multiple-cursors'
Plug 'blueshirts/darcula'
"Plug 'Valloric/YouCompleteMe'
"Plug 'SirVer/ultisnips'
"Plug 'daylerees/colour-schemes', {'rtp': 'vim'}

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
set directory=$HOME/.vim/swapfiles//

if has("gui_macvim")
    colorscheme darcula
    set guifont=Monaco:h10
endif

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

let NERDTreeMapOpenInTab = '\r'

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .DS_Store
      \ -g ""'

let g:EasyMotion_smartcase = 1

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
noremap <Leader>tt :NERDTreeFind<cr>

" save
noremap <Leader>s :w<cr>

" open file
noremap <Leader>p :CtrlP<cr>

" home
noremap <Leader>h :Welcome<cr>

" back
noremap <Leader>b :e#<cr>

" easymotion
map <Leader>y <Plug>(easymotion-prefix)
nmap <Leader>; <Plug>(easymotion-overwin-f2)
nmap <Leader>yf <Plug>(easymotion-overwin-f)
nmap <Leader>l <Plug>(easymotion-overwin-line)
nmap <Leader>yw <Plug>(easymotion-overwin-w)

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>
noremap <Leader>cs :SyntasticCheck<cr>
" NERDCommenter commands

" vimrc
noremap <Leader>,r :source $MYVIMRC<cr>
noremap <Leader>,, :tabedit $MYVIMRC<cr>
noremap <Leader>,s :! conf save<cr>

" vim plug
noremap <Leader>,pi :PlugInstall<cr>
noremap <Leader>,pu :PlugUpdate<cr>
noremap <Leader>,pc :PlugClean<cr>

" git
noremap <Leader>g :! git 

" close window
noremap <Leader>w <C-w>c
" horizontal split
noremap <Leader>dg <C-w>s<C-w>w
" other
noremap <Leader><Tab> <C-w>w
" vertical split
noremap <Leader>ds <C-w>v<C-w>w
" only
noremap <Leader>da <C-w>o
" left
noremap <Leader>dh <C-w>h
" down
noremap <Leader>dj <C-w>j
" up
noremap <Leader>dk <C-w>k
" right
noremap <Leader>dl <C-w>l
" move split right
noremap <Leader>d. 10<C-w>>
" move split left
noremap <Leader>d, 10<C-w><
" move split down
noremap <Leader>d- 10<C-w>-
" move split up
noremap <Leader>d+ 10<C-w>+
" balance split
noremap <Leader>d= 10<C-w>=
" maximize split
noremap <Leader>d\| <C-w>\|
" next tab
noremap <Leader>dn :tabnext<cr>
" previous tab
noremap <Leader>dp :tabprevious<cr>
" new tab
noremap <Leader>t :tabedit %<cr>


" changing tabs
noremap <silent> <D-1> :tabn 1<cr>
noremap <silent> <D-2> :tabn 2<cr>
noremap <silent> <D-3> :tabn 3<cr>
noremap <silent> <D-4> :tabn 4<cr>
noremap <silent> <D-5> :tabn 5<cr>
noremap <silent> <D-6> :tabn 6<cr>
noremap <silent> <D-7> :tabn 7<cr>
noremap <silent> <D-8> :tabn 8<cr>
noremap <silent> <D-9> :tabn 9<cr>

noremap <silent> <Leader>1 :tabn 1<cr>
noremap <silent> <Leader>2 :tabn 2<cr>
noremap <silent> <Leader>3 :tabn 3<cr>
noremap <silent> <Leader>4 :tabn 4<cr>
noremap <silent> <Leader>5 :tabn 5<cr>
noremap <silent> <Leader>6 :tabn 6<cr>
noremap <silent> <Leader>7 :tabn 7<cr>
noremap <silent> <Leader>8 :tabn 8<cr>
noremap <silent> <Leader>9 :tabn 9<cr>

" projects

let g:project_use_nerdtree = 0
call project#rc()
Project 'conf', 'conf'
Project 'work/snippets', 'snippets'
call project#rc('~/vg/code')
Project 'api/questioneditor', 'editor'
Project 'api/questionsV2', 'questions'
Project 'api/schemas', 'schemas'
Project 'api/author', 'author'
Project 'site/docs', 'docs'
Project 'lib/spokenmath', 'spokenmath'
Project 'lib/mathcore', 'mathcore'
Project 'lib/scoring', 'scoring'

