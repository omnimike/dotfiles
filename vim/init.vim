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
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
augroup END

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
Plug 'editorconfig/editorconfig-vim'

" language support
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'joonty/vdebug'

" lang server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
if executable('typescript-language-server')
    Plug 'ryanolsonx/vim-lsp-typescript'
endif

" Notational velocity
Plug 'https://github.com/Alok/notational-fzf-vim'

" theme
Plug 'joshdick/onedark.vim'

call plug#end()

let g:NERDTreeWinSize=40
let g:NERDTreeShowHidden=1

" disable VCS info
let g:airline_section_b = ''

" Ale config
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'typescript': ['tsserver', 'tslint'],
\   'php': ['phpcs', 'phpmd'],
\   'python': [],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:lsp_virtual_text_enabled = 0
let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '✭'}

let g:nv_search_paths = ['~/notes']

let g:vim_json_syntax_conceal = 0

"let g:vdebug_options = {}
"let g:vdebug_options['port'] = 9000
"let g:vdebug_options['ide_key'] = 'xdebug'
"let g:vdebug_options['break_on_open'] = 0

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
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

" format
augroup format
    autocmd!
    autocmd FileType typescript noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType typescript.tsx noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType javascript noremap <buffer> <silent> <Leader>f :w<cr>:silent !eslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType html noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
    autocmd FileType css noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
augroup end

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

" language server commands
nnoremap <silent> <Leader>a :LspCodeAction<cr>
nnoremap <silent> <Leader>d :LspDefinition<cr>
"nnoremap <silent> <Leader> :LspDocumentDiagnostics<cr>
"nnoremap <silent> <Leader> :LspDocumentFormat<cr>
"vnoremap <silent> <Leader> :LspDocumentRangeFormat<cr>
nnoremap <silent> <Leader>y :LspDocumentSymbol<cr>
nnoremap <silent> <Leader>l :LspHover<cr>
nnoremap <silent> <Leader>i :LspImplementation<cr>
"nnoremap <silent> <Leader>j :LspNextError<cr>
"nnoremap <silent> <Leader>k :LspPreviousError<cr>
nnoremap <silent> <Leader>u :LspReferences<cr>
nnoremap <silent> <Leader>r :LspRename<cr>
"nnoremap <silent> <Leader> :LspStatus<cr>
nnoremap <silent> <Leader>t :LspTypeDefinition<cr>
nnoremap <silent> <Leader>Y :LspWorkspaceSymbol<cr>

" linting errors
nnoremap <silent> <Leader>j :ALENext<cr>
nnoremap <silent> <Leader>k :ALEPrevious<cr>

" completion commands
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" bar cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" color scheme
if (has('termguicolors'))
    set termguicolors
endif
colorscheme onedark
syntax off

if filereadable('~/.vimrc-local')
    runtime '~/.vimrc-local'
endif
