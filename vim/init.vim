if &compatible
    set nocompatible
endif
set hidden

let mapleader = " "
set mouse=a
set list
set listchars=tab:>-,trail:·,extends:>,precedes:<

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nonumber
set nowrap
set textwidth=0
set wrapmargin=0
set autoread
set autoindent
set smartindent
set ignorecase
set smartcase
set undofile
set foldmethod=indent
set nofoldenable
set wildignore+=*/.git/*,*/tmp/*,*.swp
set colorcolumn=80
set tags=tags

if exists($HOME . '/.vim-temp/swapfiles')
    set directory=$HOME/.vim-temp/swapfiles//
endif
if exists($HOME . '/.vim-temp/backup')
    set backupdir=$HOME/.vim-temp/backup//
endif
if exists($HOME . '/.vim-temp/undo')
    set undodir=$HOME/.vim-temp/undo//
endif

augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
augroup END

" bar cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" color scheme
if (has('termguicolors'))
    set termguicolors
endif

let g:vim_json_syntax_conceal = 0

let g:NERDTreeWinSize=40
let g:NERDTreeShowHidden=1

" disable VCS info
let g:airline_section_b = ''

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" user defined functions
fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()

fun! SetIndentTwoSpace()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
endfun
command! SetIndentTwoSpace call SetIndentTwoSpace()
fun! SetIndentFourSpace()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
endfun
command! SetIndentFourSpace call SetIndentFourSpace()
fun! SetIndentTab()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set noexpandtab
endfun
command! SetIndentTab call SetIndentTab()

nnoremap <expr> zz 'zt' . winheight(0)/4 . '<c-y>'

" save
noremap <Leader>s :w<cr>

" open file
nnoremap <Leader>p :Files<CR>
nnoremap <silent> <expr> <Leader>o g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <Leader>n :NV<cr>

" search
nnoremap <Leader>/ :Rg 
nnoremap <Leader>* :Rg <cword><CR>

" code/comments
noremap \w :call TrimWhitespace()<cr>
noremap \2 :call SetIndentTwoSpace()<cr>
noremap \4 :call SetIndentFourSpace()<cr>
noremap \t :call SetIndentTab()<cr>
noremap \h :nohlsearch<cr>
noremap \n :set invnumber<cr>
noremap <silent> \s :if exists("g:syntax_on") <Bar>
    \   syntax off <Bar>
    \ else <Bar>
    \   syntax enable <Bar>
    \ endif <CR>

" vimrc
noremap \, :source $MYVIMRC<cr>
noremap <Leader>, :tabedit $MYVIMRC<cr>

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
" We force vim-sensible to load early so we can turn off syntax highlighting
call plug#load('vim-sensible')

" core editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tommcdo/vim-exchange'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'tpope/vim-unimpaired'

" ide
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdcommenter'

" theme
Plug 'joshdick/onedark.vim'

if filereadable($HOME . '/.vimrc-local')
    source $HOME/.vimrc-local
endif

call plug#end()

colorscheme onedark
syntax on
