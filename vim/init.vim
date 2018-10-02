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
"Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
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
"Plug 'joonty/vdebug'
Plug 'sheerun/vim-polyglot'
Plug 'francoiscabrol/ranger.vim'
if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
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
\   'python': [],
\}
let g:ale_php_phpcs_executable = 'phpcs --standard=~/work/phpcs.xml'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

au BufRead,BufNewFile *.pql set filetype=sql

if has('nvim')
    let g:deoplete#enable_at_startup = 1
    let g:LanguageClient_settingsPath = "~/.vim/settings.json"
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'php': ['php', '~/.composer/vendor/bin/php-language-server.php'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }
endif

let g:vim_json_syntax_conceal = 0

"let g:vdebug_options = {}
"let g:vdebug_options['port'] = 9000
"let g:vdebug_options['ide_key'] = 'xdebug'
"let g:vdebug_options['break_on_open'] = 0

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
noremap <Leader>c2 :call SetIndentTwoSpace()<cr>
noremap <Leader>c4 :call SetIndentFourSpace()<cr>
noremap <Leader>ct :call SetIndentTab()<cr>

" vimrc
noremap <Leader>;, :source $MYVIMRC<cr>
noremap <Leader>, :tabedit $MYVIMRC<cr>

if has('nvim')
    " language server commands
    " LanguageClient_contextMenu()
    " LanguageClient_textDocument_hover()
    " LanguageClient_textDocument_definition()
    " LanguageClient_textDocument_typeDefinition()
    " LanguageClient_textDocument_implementation()
    " LanguageClient#textDocument_rename()
    " LanguageClient_textDocument_documentSymbol()
    " LanguageClient_textDocument_references()
    " LanguageClient_textDocument_codeAction()
    " LanguageClient_textDocument_completion()
    " LanguageClient_textDocument_formatting()
    " LanguageClient_textDocument_rangeFormatting()
    " LanguageClient_textDocument_documentHighlight()
    " LanguageClient_clearDocumentHighlight()
    " LanguageClient_workspace_symbol()
    nnoremap <silent> <Leader>ll :call LanguageClient_textDocument_references()<cr>
    nnoremap <silent> <Leader>lj :call LanguageClient_textDocument_definition()<cr>
    nnoremap <silent> <Leader>lk :call LanguageClient_textDocument_hover()<cr>
    nnoremap <silent> <Leader>lh :call LanguageClient_textDocument_documentHighlight()<cr>
    nnoremap <silent> <Leader>lH :call LanguageClient_clearDocumentHighlight()<cr>
    nnoremap <silent> <Leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
    nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_rename()<cr>
    nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_formatting()<cr>
    vnoremap <silent> <Leader>lf :call LanguageClient_textDocument_rangeFormatting()<cr>

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

" color scheme
if (has('termguicolors'))
    set termguicolors
endif
syntax on
colorscheme onedark

if filereadable('~/.vimrc-local')
    runtime '~/.vimrc-local'
endif
