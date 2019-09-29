
Plug 'editorconfig/editorconfig-vim'

" language support
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jeetsukumaran/vim-pythonsense'
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

" Ale config
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'typescript': ['tsserver', 'tslint'],
\   'php': ['phpcs', 'phpmd'],
\   'python': [],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:polyglot_disabled = []

let g:lsp_virtual_text_enabled = 0
let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '✭'}

let g:nv_search_paths = ['~/notes']

"let g:vdebug_options = {}
"let g:vdebug_options['port'] = 9000
"let g:vdebug_options['ide_key'] = 'xdebug'
"let g:vdebug_options['break_on_open'] = 0

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

" format
augroup format
    autocmd!
    autocmd FileType typescript noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType typescript.tsx noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType javascript noremap <buffer> <silent> <Leader>f :w<cr>:silent !eslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType html noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
    autocmd FileType css noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
augroup end


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

