set nocompatible

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
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
Plug 'elzr/vim-json'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wincent/command-t'
"Plug 'tpope/vim-obsession'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-unimpaired'
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
set autoindent
set smartindent
set undofile
set foldmethod=indent
set nofoldenable
" Save files on focus lost
autocmd BufLeave,FocusLost * silent! wall
syntax enable
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

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
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '☡'
let g:syntastic_style_warning_symbol = '¡'
let g:syntastic_enable_balloons = 1

let g:vim_json_syntax_conceal = 0

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

" exec
noremap <Leader>x :!

" toggles
noremap <Leader>;p :set invpaste paste?<cr>
noremap <Leader>;n :set invnumber number?<cr>
noremap <Leader>;h :set hlsearch!<cr>
noremap <Leader>;s :syntax enable<cr>
noremap <Leader>;t :NERDTreeFind<cr>

" save
noremap <Leader>s :w<cr>

" open file
noremap <Leader>p :CtrlP<cr>

" home
noremap <Leader>h :tabedit<cr>:Welcome<cr>

" restore
noremap <Leader>r :source '~/.session.vim'<cr>

" back
noremap <Leader>b :e#<cr>

" easymotion
map <Leader>y <Plug>(easymotion-prefix)
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>yf <Plug>(easymotion-bd-f2)
nmap <Leader>yf <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
map <Leader>yw <Plug>(easymotion-bd-w)
nmap <Leader>yw <Plug>(easymotion-overwin-w)

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

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
" other
noremap <Leader><Tab> <C-w>w
" new tab
"noremap <Leader>t :tabedit %<cr>


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
Project 'work/test-pages', 'test-pages'
Project 'work/snippets', 'snippets'
Project 'vg/scripts', 'vgscripts'
call project#rc('~/vg/code')
Project 'api/questioneditor', 'editor'
Project 'api/questionsV2', 'questions'
Project 'api/schemas', 'schemas'
Project 'api/author', 'author'
Project 'site/docs', 'docs'
Project 'lib/spokenmath', 'spokenmath'
Project 'lib/mathcore', 'mathcore'
Project 'lib/scoring', 'scoring'

