set nocompatible
set hidden

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'elzr/vim-json'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'w0rp/ale'
Plug 'joshdick/onedark.vim'

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
set wildignore+=*/.git/*,*/tmp/*,*.swp
" Save files on focus lost
autocmd BufLeave,FocusLost * silent! wall
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

" Ale config
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:vim_json_syntax_conceal = 0

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
noremap <Leader>;p :set invpaste paste?<cr>
noremap <Leader>;n :set invnumber number?<cr>
noremap <Leader>;h :set hlsearch!<cr>
noremap <Leader>;s :syntax enable<cr>

noremap <Leader>t :NERDTreeFind<cr>

" save
noremap <Leader>s :w<cr>

" open file
nnoremap <Leader>p :FZF<CR>

" back
noremap <Leader>b :e#<cr>

" easymotion
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>

" vimrc
noremap <Leader>;, :source $MYVIMRC<cr>
noremap <Leader>, :tabedit $MYVIMRC<cr>

" close window
noremap <Leader>w <C-w>c
" other
noremap <Leader><Tab> <C-w>w

" changing tabs
noremap <silent> <Leader>1 :tabn 1<cr>
noremap <silent> <Leader>2 :tabn 2<cr>
noremap <silent> <Leader>3 :tabn 3<cr>
noremap <silent> <Leader>4 :tabn 4<cr>
noremap <silent> <Leader>5 :tabn 5<cr>
noremap <silent> <Leader>6 :tabn 6<cr>
noremap <silent> <Leader>7 :tabn 7<cr>
noremap <silent> <Leader>8 :tabn 8<cr>
noremap <silent> <Leader>9 :tabn 9<cr>

" color scheme
if (has("termguicolors"))
    set termguicolors
endif
syntax on
colorscheme onedark

