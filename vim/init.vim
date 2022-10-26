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
set conceallevel=2
set foldmethod=indent
set nofoldenable
set wildignore+=*/.git/*,*/tmp/*,*.swp
set colorcolumn=80
set tags=tags;/

set directory=$HOME/.vim-temp/swapfiles//
set backupdir=$HOME/.vim-temp/backup//
set undodir=$HOME/.vim-temp/undo//

augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
augroup END

" bar cursor in insert mode (doesn't seem to work in tmux)
if has('cursorshape')
    if exists('$TMUX')
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    elseif $TERM_PROGRAM =~ "iTerm"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    endif
endif

" color scheme
" this has issues under mosh
if (has('termguicolors'))
    set termguicolors
endif

let g:vim_json_syntax_conceal = 0

let g:NERDTreeWinSize=60
let g:NERDTreeShowHidden=1

" disable VCS info
let g:airline_section_b = ''
"
" Ale config
let g:ale_linters = {}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:polyglot_disabled = []

let g:asyncomplete_auto_popup = 0

let g:lsp_async_completion = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '✭'}

let g:vim_markdown_math = 1

let g:gitgutter_map_keys = 0

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 30 

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
fun! SetIndentFourSpace()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
endfun
fun! SetIndentTab()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set noexpandtab
endfun

" save
nnoremap <Leader>s :w<cr>

" open file
nnoremap <Leader>p :Files<CR>
nnoremap <silent> <expr> <Leader>o g:NERDTree.IsOpen() ? ":NERDTreeClose<CR>" : bufexists(expand('%')) ? (":NERDTree %:p:h<CR>:NERDTreeFind " . expand('%') . "<CR>") : ":NERDTree<CR>"
nnoremap <Leader>a :A<CR>
nnoremap <Leader>u :Buffers<cr>
nnoremap <Leader>z :bprev\|bdelete #<cr>

" search
nnoremap <Leader>/ :Rg 
nnoremap <Leader>* :Rg <cword><CR>

" clipboard
vnoremap <Leader>y :OSCYank<cr>

" code/comments
nnoremap <Leader>h :nohlsearch<cr>
nnoremap <Leader>n :set invnumber<cr>
nnoremap <Leader>r :set relativenumber!<cr>
nnoremap \w :call TrimWhitespace()<cr>
nnoremap \2 :call SetIndentTwoSpace()<cr>
nnoremap \4 :call SetIndentFourSpace()<cr>
nnoremap \t :call SetIndentTab()<cr>
nnoremap \i :set foldmethod=indent<cr>
nnoremap \m :set foldmethod=manual<cr>
nnoremap <silent> \s :if exists("g:syntax_on") <Bar>
    \   syntax off <Bar>
    \ else <Bar>
    \   syntax enable <Bar>
    \ endif <CR>
xmap <Leader>= <Plug>(EasyAlign)
nmap <Leader>= <Plug>(EasyAlign)

" vimrc
nnoremap <Leader>< :source $MYVIMRC<cr>
nnoremap <Leader>, :edit $MYVIMRC<cr>

" language server commands
"nnoremap <silent> <Leader> :LspCodeAction<cr>
nnoremap <silent> <Leader><Leader>d :LspDefinition<cr>
"nnoremap <silent> <Leader> :LspDocumentDiagnostics<cr>
"nnoremap <silent> <Leader> :LspDocumentFormat<cr>
"vnoremap <silent> <Leader> :LspDocumentRangeFormat<cr>
"nnoremap <silent> <Leader> :LspDocumentSymbol<cr>
nnoremap <silent> <Leader><Leader>l :LspHover<cr>
"nnoremap <silent> <Leader> :LspImplementation<cr>
nnoremap <silent> <Leader><Leader>e :LspReferences<cr>
nnoremap <silent> <Leader><Leader>r :LspRename<cr>
"nnoremap <silent> <Leader> :LspStatus<cr>
nnoremap <silent> <Leader><Leader>t :LspTypeDefinition<cr>
"nnoremap <silent> <Leader> :LspWorkspaceSymbol<cr>
nnoremap <silent> <Leader><Leader>j :LspNextError<cr>
nnoremap <silent> <Leader><Leader>k :LspPreviousError<cr>

" completion commands
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


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
Plug 'tpope/vim-tbone'
Plug 'ojroques/vim-oscyank'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'
"Plug 'tpope/vim-unimpaired'

" ide
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
"Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'omnimike/a.vim'

" language support
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

if v:version >= 800
    " lang server
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'pdavydov108/vim-lsp-cquery'
endif

" theme
Plug 'joshdick/onedark.vim'

if filereadable($HOME . '/.vimrc-local-plugins')
    source $HOME/.vimrc-local-plugins
endif

call plug#end()

if filereadable($HOME . '/.vimrc-local')
    noremap \, :edit ~/.vimrc-local<cr>
    source $HOME/.vimrc-local
endif

colorscheme onedark
syntax on
