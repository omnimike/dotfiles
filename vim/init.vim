if &compatible
    set nocompatible
endif
set hidden

let mapleader = " "
set mouse=a
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,space:.

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tommcdo/vim-exchange'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'w0rp/ale'
Plug 'joshdick/onedark.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'joonty/vdebug'
Plug 'sheerun/vim-polyglot'
if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    Plug 'roxma/nvim-completion-manager'
endif

call plug#end()

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
set colorcolumn=80
" Save files on focus lost
autocmd BufLeave,FocusLost * silent! wall
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

let g:NERDTreeWinSize=40

" Ale config
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'php': ['phpcs', 'phpmd'],
\}
let g:ale_php_phpcs_executable = 'phpcs --standard=~/work/phpcs.xml'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

if has('nvim')
    let g:LanguageClient_serverCommands = {
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio'],
    \ 'php': ['php', '~/.composer/vendor/bin/php-language-server.php'],
    \ }
endif

let g:vim_json_syntax_conceal = 0

let g:vdebug_options = {}
let g:vdebug_options['port'] = 9000
let g:vdebug_options['ide_key'] = 'xdebug'
let g:vdebug_options['break_on_open'] = 0

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

noremap <Leader>t :NERDTree<cr>

nnoremap <expr> zz 'zt' . winheight(0)/4 . '<c-y>'

" save
noremap <Leader>s :w<cr>

" open file
nnoremap <Leader>p :FZF<CR>

nnoremap <Leader>/ :Rg 
nnoremap <Leader>* :Rg <cword><CR>

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>

" vimrc
noremap <Leader>;, :source $MYVIMRC<cr>
noremap <Leader>, :tabedit $MYVIMRC<cr>

if has('nvim')
    " language server
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <Leader>ld :call LanguageClient_textDocument_definition()<cr>
    nnoremap <silent> <Leader>lh :call LanguageClient_textDocument_hover()<cr>
    nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_rename()<cr>
    nnoremap <silent> <Leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
    nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_references()<cr>
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

" color scheme
if (has('termguicolors'))
    set termguicolors
endif
if &term =~# '^screen'
    let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
    let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
endif
syntax on
colorscheme onedark

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

if filereadable('~/.vimrc-local')
    runtime '~/.vimrc-local'
endif
