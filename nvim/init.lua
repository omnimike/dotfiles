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

vim.g.signify_disable_by_default = true

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

require("nvim-tree").setup {
  view = {
    width = 50,
  },
}

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

local wk = require("which-key")
wk.setup {
  presets = {
    operators = true,
    motions = true,
    text_objects = true,
    windows = true,
    nav = true,
    z = true,
    g = true,
  },
}

function leadermap(key, cmd, desc)
  wk.register{['<leader>' .. key] = {cmd, desc}}
end

function localleadermap(key, cmd, desc)
  wk.register{['<leader><leader>' .. key] = {cmd, desc}}
end

function altleadermap(key, cmd, desc)
  wk.register{['\\' .. key] = {cmd, desc}}
end

-- save
leadermap('s', ':w<cr>', 'Save')

-- vimrc
leadermap(',', ':edit $MYVIMRC<cr>', 'Edit init.lua')
leadermap('<', ':source $MYVIMRC<cr>', 'Reload init.lua')

-- open file
leadermap('p', telescope_builtin.find_files, 'Find file')
leadermap('u', telescope_builtin.buffers, 'Switch buffer')
leadermap('i', telescope_builtin.oldfiles, 'Recent files')
leadermap('a', ':A<cr>', 'Alternate file')
leadermap('w', ':bprev|bdelete #<cr>', 'Close buffer')
leadermap('o', ':NvimTreeFindFileToggle!<cr>', 'File tree')

-- telescope
leadermap('ff', telescope_builtin.resume, 'Reopen picker')
leadermap('f/', telescope_builtin.current_buffer_fuzzy_find, 'Find in buffer')
leadermap('fh', telescope_builtin.command_history, 'Command history')
leadermap('fH', telescope_builtin.help_tags, 'Help tags')

-- clipboard
leadermap('y', ':OSCYankVisual<cr>', 'Copy to system clipboard')

leadermap('h', ':nohlsearch<cr>', 'Clear search')
leadermap('n', ':set invnumber<cr>', 'Toggle line numbers')

altleadermap('g', ':SignifyToggle<cr>', 'Toggle gutter')
altleadermap('w', ':call TrimWhitespace()<cr>', 'Trim trailing whitespace')
altleadermap('i2', ':call SetIndentTwoSpace()<cr>', 'Set indent 2 space')
altleadermap('i4', ':call SetIndentFourSpace()<cr>', 'Set indent 4 space')
altleadermap('it', ':call SetIndentTab()<cr>', 'Set indent tab')
altleadermap('fi', ':set foldmethod=indent<cr>', 'Set foldmethod indent')
altleadermap('fm', ':set foldmethod=manual<cr>', 'Set foldmethod manual')
altleadermap('s', ':setlocal spell!<cr>', 'Toggle spell')

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
