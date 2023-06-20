vim.g.mapleader = " "

vim.o.mouse = "a"
vim.o.list = true
vim.o.listchars = "tab:>-,trail:·,extends:>,precedes:<"

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
vim.o.foldmethod = "indent"
vim.o.foldenable = false
vim.opt.wildignore:append {"*/.git/*", "*/tmp/*", "*.swp"}
vim.o.colorcolumn = "80"
vim.o.tags = "tags;/"

vim.o.directory = os.getenv("HOME") .. "/.vim-temp/swapfiles//"
vim.o.backupdir = os.getenv("HOME") .. "/.vim-temp/backup//"
vim.o.undodir = os.getenv("HOME") .. "/.vim-temp/undo//"

vim.o.termguicolors = true

vim.g.vim_json_syntax_conceal = 0

vim.g.signify_disable_by_default = true

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.cmd([[
fun! TrimWhitespace()
  let l:save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", l:save_cursor)
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

require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require("telescope").load_extension("fzf")
local telescope_builtin = require("telescope.builtin")

require("nvim-tree").setup {
  view = {
    width = 50,
  },
}

require("lualine").setup()

require("nvim-treesitter.configs").setup {
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

require("nvim-treesitter.configs").setup {
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

require("indent_blankline").setup {
  enabled = false,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

require("other-nvim").setup {
  rememberBuffers = false,
  mappings = {
    {
      -- cpp
      pattern = "(.*/)([^/]*).cpp$",
      target = {
          {target = "%1%2.h", context = "header"},
          {target = "%1test/%2Test.cpp", context = "test"},
      },
    },
    {
      -- h to cpp
      pattern = "(.*).h$",
      target = "%1.cpp",
      context = "source",
    },
    {
      -- test to cpp
      pattern = "(.*)/test/([A-Za-z0-9]+)Test.cpp$",
      target = "%1/%2.cpp",
      context = "source",
    },
    {
      -- init.lua to .vimrc-local
      pattern = os.getenv("MYVIMRC"),
      target = os.getenv("HOME") .. "/.vimrc-local",
      context = "local",
    },
  }
}

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
}

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

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

function leadermap(key, cmd, desc, opts)
  local args = {cmd, desc}
  if opts then
    for k,v in pairs(opts) do
      args[k] = v
    end
  end
  wk.register{["<leader>" .. key] = args}
end

-- save
leadermap("s", ":w<cr>", "Save")

-- vimrc
leadermap(",", ":edit $MYVIMRC<cr>", "Edit init.lua")
leadermap("<", ":source $MYVIMRC<cr>", "Reload init.lua")

-- files
leadermap("p", telescope_builtin.find_files, "Find file")
leadermap("i", telescope_builtin.oldfiles, "Recent files")
leadermap("o", ":NvimTreeFindFileToggle!<cr>", "File tree")

-- alternates
leadermap("g", ":Other<cr>", "Alternate file")

-- buffers
leadermap("u", telescope_builtin.buffers, "Switch buffer")
leadermap("w", ":bprev|bdelete #<cr>", "Close buffer")

-- search
leadermap("/", telescope_builtin.current_buffer_fuzzy_find, "Find in buffer")
leadermap("h", ":nohlsearch<cr>", "Clear search")

-- find
leadermap("ff", telescope_builtin.resume, "Reopen picker")
leadermap("fh", telescope_builtin.command_history, "Command history")
leadermap("fH", telescope_builtin.help_tags, "Help tags")

-- clipboard
leadermap("y", ":OSCYankVisual<cr>", "Copy to system clipboard")

-- formatting
leadermap("d", ":call TrimWhitespace()<cr>", "Trim trailing whitespace")

-- toggle
leadermap("tn", ":set invnumber<cr>", "Toggle line numbers")
leadermap("tg", ":SignifyToggle<cr>", "Toggle gutter")
leadermap("ti2", ":call SetIndentTwoSpace()<cr>", "Set indent 2 space")
leadermap("ti4", ":call SetIndentFourSpace()<cr>", "Set indent 4 space")
leadermap("tit", ":call SetIndentTab()<cr>", "Set indent tab")
leadermap("tl", ":IndentBlanklineToggle!<cr>", "Toggle indent guide")
leadermap("tfi", ":set foldmethod=indent<cr>", "Set foldmethod indent")
leadermap("ffm", ":set foldmethod=manual<cr>", "Set foldmethod manual")
leadermap("ts", ":setlocal spell!<cr>", "Toggle spell")

vim.cmd([[
  augroup init
    autocmd!
    " Save files on focus lost
    autocmd BufLeave,FocusLost * silent! wall
    autocmd BufRead,BufNewFile *.pql set filetype=sql
    autocmd BufRead,BufNewFile *.hql set filetype=sql
  augroup END
]])

vim.cmd("colorscheme onedark")
vim.cmd("syntax on")

vim.cmd([[
if filereadable($HOME . "/.vimrc-local")
  source $HOME/.vimrc-local
endif
]])
