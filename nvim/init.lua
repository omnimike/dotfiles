vim.g.mapleader = " "

vim.o.mouse = "a"
vim.o.list = true
vim.o.listchars = "tab:>-,trail:·,extends:>,precedes:<"

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.wrap = false
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.conceallevel = "2"
vim.o.foldmethod = "indent"
vim.o.foldenable = false
vim.opt.wildignore:append {"*/.git/*", "*/tmp/*", "*.swp"}
vim.o.colorcolumn = "80"
vim.o.tags = "tags;/"

vim.o.directory = os.getenv("HOME") .. "/.vim-temp/swapfiles//"
vim.o.backupdir = os.getenv("HOME") .. "/.vim-temp/backup//"
vim.o.undodir = os.getenv("HOME") .. "/.vim-temp/undo//"

vim.cmd([[
  augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
  augroup END
]])

vim.o.termguicolors = true

vim.g.vim_json_syntax_conceal = 0

vim.g.NERDTreeWinSize = 60
vim.g.NERDTreeShowHidden = 1

vim.g.gitgutter_map_keys = 0

vim.g.sleuth_heuristics = 0

if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep"
    vim.o.grepformat = "%f:%l:%c:%m"
end

vim.cmd([[
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
]])

-- save
vim.keymap.set("n", "<leader>s", ":w<cr>")

-- open file
vim.keymap.set("n", "<leader>p", ":Files<cr>")
vim.keymap.set("n", "<leader>o", 'g:NERDTree.IsOpen() ? ":NERDTreeClose<cr>" : bufexists(expand("%")) ? (":NERDTree %:p:h<CR>:NERDTreeFind " . expand("%") . "<CR>") : ":NERDTree<cr>"', {expr = true})
vim.keymap.set("n", "<leader>a", ":A<cr>")
vim.keymap.set("n", "<leader>u", ":Buffers<cr>")
vim.keymap.set("n", "<leader>z", ":bprev|bdelete #<cr>")

-- search
vim.keymap.set("n", "<leader>/", ":Rg")
vim.keymap.set("n", "<leader>*", ":Rg <cword><cr>")

-- clipboard
vim.keymap.set("v", "<leader>y", ":OSCYankVisual<cr>")

-- code/comments
vim.keymap.set("n", "<leader>h", ":nohlsearch<cr>")
vim.keymap.set("n", "<leader>n", ":set invnumber<cr>")
vim.keymap.set("n", "<leader>r", ":set relativenumber!<cr>")
vim.keymap.set("n", "\\w", ":call TrimWhitespace()<cr>")
vim.keymap.set("n", "\\2", ":call SetIndentTwoSpace()<cr>")
vim.keymap.set("n", "\\4", ":call SetIndentFourSpace()<cr>")
vim.keymap.set("n", "\\t", ":call SetIndentTab()<cr>")
vim.keymap.set("n", "\\i", ":set foldmethod=indent<cr>")
vim.keymap.set("n", "\\m", ":set foldmethod=manual<cr>")

-- vimrc
vim.keymap.set("n", "<leader><", ":source $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>,", ":edit $MYVIMRC<cr>")

vim.cmd([[
if filereadable($HOME . '/.fzf/plugin/fzf.vim')
  source $HOME/.fzf/plugin/fzf.vim
endif
]])

vim.cmd([[
if filereadable($HOME . '/.vimrc-local')
  noremap \, :edit ~/.vimrc-local<cr>
  source $HOME/.vimrc-local
endif
]])

vim.cmd("colorscheme onedark")
vim.cmd("syntax on")
