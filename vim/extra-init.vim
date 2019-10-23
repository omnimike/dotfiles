
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'typescript': ['tsserver', 'tslint'],
\   'php': ['phpcs', 'phpmd'],
\   'python': [],
\}

" format
augroup format
    autocmd!
    autocmd FileType typescript noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType typescript.tsx noremap <buffer> <silent> <Leader>f :w<cr>:silent !tslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType javascript noremap <buffer> <silent> <Leader>f :w<cr>:silent !eslint --fix %; prettier --write %<cr>:e<cr>
    autocmd FileType html noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
    autocmd FileType css noremap <buffer> <silent> <Leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>
augroup end

if executable('clangd')
    augroup lsp_c
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

if executable('typescript-language-server')
    Plug 'ryanolsonx/vim-lsp-typescript'
endif

Plug 'jeetsukumaran/vim-pythonsense'
"Plug 'joonty/vdebug'
