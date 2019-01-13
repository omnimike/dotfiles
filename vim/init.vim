if &compatible
    set nocompatible
endif
set hidden

let mapleader = " "
set mouse=a
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,space:.

call plug#begin('~/.vim/plugged')

" core editing
Plug 'tpope/vim-sensible'
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
Plug 'jremmen/vim-ripgrep'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'scrooloose/nerdcommenter'

" language support
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'ianks/vim-tsx'
"Plug 'joonty/vdebug'

" lang server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-typescript'

" theme
Plug 'joshdick/onedark.vim'

call plug#end()

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

" disable VCS info
let g:airline_section_b = ''

" Ale config
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'typescript': ['tslint'],
\   'php': ['phpcs', 'phpmd'],
\   'python': [],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1 
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '✭'}

let g:vim_json_syntax_conceal = 0

"let g:vdebug_options = {}
"let g:vdebug_options['port'] = 9000
"let g:vdebug_options['ide_key'] = 'xdebug'
"let g:vdebug_options['break_on_open'] = 0

au BufRead,BufNewFile *.pql set filetype=sql
au BufRead,BufNewFile *.hql set filetype=sql

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
nnoremap <Leader>p :FZF<CR>
nnoremap <silent> <expr> <Leader>o g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" search
nnoremap <Leader>/ :Rg 
nnoremap <Leader>* :Rg <cword><CR>

" format
noremap <silent> <Leader>f :Prettier<cr>

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>
noremap <Leader>c2 :call SetIndentTwoSpace()<cr>
noremap <Leader>c4 :call SetIndentFourSpace()<cr>
noremap <Leader>ct :call SetIndentTab()<cr>

" vimrc
noremap <Leader>;, :source $MYVIMRC<cr>
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
nnoremap <silent> <Leader>j :LspNextError<cr>
nnoremap <silent> <Leader>k :LspPreviousError<cr>
nnoremap <silent> <Leader>u :LspReferences<cr>
nnoremap <silent> <Leader>r :LspRename<cr>
"nnoremap <silent> <Leader> :LspStatus<cr>
nnoremap <silent> <Leader>t :LspTypeDefinition<cr>
nnoremap <silent> <Leader>Y :LspWorkspaceSymbol<cr>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" color scheme
if (has('termguicolors'))
    set termguicolors
endif
syntax on
colorscheme onedark

" bar cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

if filereadable('~/.vimrc-local')
    runtime '~/.vimrc-local'
endif
