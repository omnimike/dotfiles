set nocompatible
set hidden

let mapleader = " "
set mouse=a
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'w0rp/ale'
Plug 'joshdick/onedark.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'joonty/vdebug'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

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


let g:LanguageClient_autoStart = 0

let g:LanguageClient_serverCommands = {}
if executable('javascript-typescript-stdio')
    let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
    autocmd FileType php LanguageClientStart
    autocmd FileType javascript setlocal completefunc=LanguageClient#complete
endif
if executable('php-language-server.php')
    let g:LanguageClient_serverCommands.php = ['php', '~/.composer/vendor/bin/php-language-server.php']
    autocmd FileType php LanguageClientStart
    autocmd FileType php setlocal completefunc=LanguageClient#complete
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

" quit
noremap <Leader>q :q<cr>

" toggles
noremap <Leader>;p :set invpaste paste?<cr>
noremap <Leader>;n :set invnumber number?<cr>
noremap <Leader>;h :set hlsearch!<cr>
noremap <Leader>;s :syntax enable<cr>

noremap <Leader>t :NERDTreeFind<cr>

nnoremap <expr> zz 'zt' . winheight(0)/4 . '<c-y>'

" save
noremap <Leader>s :w<cr>

" open file
nnoremap <Leader>p :FZF<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

nnoremap <Leader>/ :Rg 
nnoremap <Leader>* :Rg <cword><CR>

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>

" vimrc
noremap <Leader>;, :source $MYVIMRC<cr>
noremap <Leader>, :tabedit $MYVIMRC<cr>

" language server
noremap <Leader>ld :call LanguageClient_textDocument_definition()<cr>
noremap <Leader>lh :call LanguageClient_textDocument_hover()<cr>
noremap <Leader>lr :call LanguageClient_textDocument_rename()<cr>
noremap <Leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
noremap <Leader>lf :call LanguageClient_textDocument_references()<cr>

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
