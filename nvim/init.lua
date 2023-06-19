vim.g.mapleader = ' '

vim.o.mouse = 'a'
vim.o.list = true
vim.o.listchars = 'tab:>-,trail:·,extends:>,precedes:<'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.wrap = false
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.foldmethod = 'indent'
vim.o.foldenable = false
vim.opt.wildignore:append {'*/.git/*', '*/tmp/*', '*.swp'}
vim.o.colorcolumn = '80'
vim.o.tags = 'tags;/'

vim.o.directory = os.getenv('HOME') .. '/.vim-temp/swapfiles//'
vim.o.backupdir = os.getenv('HOME') .. '/.vim-temp/backup//'
vim.o.undodir = os.getenv('HOME') .. '/.vim-temp/undo//'

vim.o.termguicolors = true

vim.g.vim_json_syntax_conceal = 0

if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = 'rg --vimgrep'
    vim.o.grepformat = '%f:%l:%c:%m'
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
vim.keymap.set('n', '<leader>s', ':w<cr>')

-- vimrc
vim.keymap.set('n', '<leader>,', ':edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader><', ':source $MYVIMRC<cr>')

-- Telescope setup
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
}
require('telescope').load_extension('fzf')
local telescope_builtin = require('telescope.builtin')
require("nvim-tree").setup()
require('lualine').setup()
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 1024 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
}

require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = "@statement.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
      },
    },
  },
}

-- open file
vim.keymap.set('n', '<leader>p', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>u', telescope_builtin.buffers)
vim.keymap.set('n', '<leader>i', telescope_builtin.oldfiles)
vim.keymap.set('n', '<leader>a', ':A<cr>')
vim.keymap.set('n', '<leader>w', ':bprev|bdelete #<cr>')
vim.keymap.set('n', '<leader>o', ':NvimTreeFindFileToggle!<cr>')

-- telescope
vim.keymap.set('n', '<leader>ff', telescope_builtin.resume)
vim.keymap.set('n', '<leader>f/', telescope_builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags)
vim.keymap.set('n', '<leader>fr', telescope_builtin.registers)
vim.keymap.set('n', '<leader>fj', telescope_builtin.jumplist)
vim.keymap.set('n', '<leader>f\'', telescope_builtin.marks)
vim.keymap.set('n', '<leader>fc', telescope_builtin.command_history)

-- clipboard
vim.keymap.set('v', '<leader>y', ':OSCYankVisual<cr>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>n', ':set invnumber<cr>')

vim.keymap.set('n', '\\w', ':call TrimWhitespace()<cr>')
vim.keymap.set('n', '\\i2', ':call SetIndentTwoSpace()<cr>')
vim.keymap.set('n', '\\i4', ':call SetIndentFourSpace()<cr>')
vim.keymap.set('n', '\\it', ':call SetIndentTab()<cr>')
vim.keymap.set('n', '\\fi', ':set foldmethod=indent<cr>')
vim.keymap.set('n', '\\fm', ':set foldmethod=manual<cr>')

-- spell
vim.keymap.set('n', '\\s', ':setlocal spell!<cr>')
vim.keymap.set('n', '<leader><leader>s', telescope_builtin.spell_suggest)

vim.cmd([[
  augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
  augroup END
]])

vim.cmd('colorscheme onedark')
vim.cmd('syntax on')

vim.cmd([[
if filereadable($HOME . '/.vimrc-local')
  noremap \, :edit ~/.vimrc-local<cr>
  source $HOME/.vimrc-local
endif
]])
