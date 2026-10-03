-- vim config
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

-- Create the directories automatically if they don't exist
local data_dir = vim.fn.stdpath("state")
vim.fn.mkdir(data_dir .. "/undo", "p")
vim.fn.mkdir(data_dir .. "/backup", "p")

-- Enable persistent undo across editor sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Enable backups and set backup directory
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

vim.o.termguicolors = true

vim.g.vim_json_syntax_conceal = 0

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

-- Extension config

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
    width = function()
      local dynamic_width = vim.go.columns - 81
      return math.max(20, math.min(dynamic_width, 50))
    end,
  },
}

require("lualine").setup {}

require("nvim-treesitter").setup {}

-- Install parsers for the languages used here (async; no-op when already installed)
require("nvim-treesitter").install { "lua", "vim", "vimdoc", "query", "bash", "c", "cpp", "python", "markdown", "markdown_inline" }

-- Treesitter highlighting for every filetype with an installed parser, skipping huge files
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > 1024 * 1024 then return end -- 1MB cap, as before
    pcall(vim.treesitter.start, ev.buf)
  end,
})

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
  },
}

local function ts_textobject(key, capture)
  vim.keymap.set({ "x", "o" }, key, function()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end, { desc = "Select " .. capture })
end

ts_textobject("af", "@function.outer")
ts_textobject("if", "@function.inner")
ts_textobject("ac", "@class.outer")
ts_textobject("ic", "@class.inner")
ts_textobject("as", "@statement.outer")
ts_textobject("ib", "@block.inner")
ts_textobject("ab", "@block.outer")
ts_textobject("ap", "@parameter.outer")
ts_textobject("ip", "@parameter.inner")

require("ibl").setup()

require("mini.ai").setup()
require("mini.comment").setup()
require("mini.surround").setup()

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

require("trouble").setup {}

require("gitsigns").setup()

require("notify").setup({
  background_colour = "#1e1e2e",
})

require("noice").setup()

-- Set up blink.cmp. Snippets use Neovim's built-in vim.snippet (no extra plugin);
-- cmdline completion is enabled by default.
require("blink.cmp").setup {
  keymap = {
    preset = "none",
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-space>"] = { "show", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<Tab>"] = { "select_and_accept", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
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

-- Hotkey setup

function leadermap(key, cmd, desc, opts)
  local args = {"<leader>" .. key, cmd, desc=desc}
  if opts then
    for k,v in pairs(opts) do
      args[k] = v
    end
  end
  wk.add(args)
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
leadermap("a", ":Other<cr>", "Alternate file")

-- buffers
leadermap("u", telescope_builtin.buffers, "Switch buffer")
leadermap("w", ":bprev|bdelete #<cr>", "Close buffer")
leadermap("W", ":bprev|bdelete! #<cr>", "Close buffer")

-- search
leadermap("/", telescope_builtin.current_buffer_fuzzy_find, "Find in buffer")
leadermap("h", ":nohlsearch<cr>", "Clear search")

-- find
leadermap("ff", telescope_builtin.resume, "Reopen picker")
leadermap("fh", telescope_builtin.command_history, "Command history")
leadermap("fH", telescope_builtin.help_tags, "Help tags")

-- format
leadermap("fw", ":call TrimWhitespace()<cr>", "Remove trailing whitespace")

-- clipboard (OSC 52)
vim.keymap.set("v", "<leader>y", '"+y')

-- toggle
leadermap("tn", ":set invnumber<cr>", "Toggle line numbers")
leadermap("tg", ":Gitsigns toggle_signs<cr>", "Toggle gutter")
leadermap("ti2", ":call SetIndentTwoSpace()<cr>", "Set indent 2 space")
leadermap("ti4", ":call SetIndentFourSpace()<cr>", "Set indent 4 space")
leadermap("tit", ":call SetIndentTab()<cr>", "Set indent tab")
leadermap("tl", ":IBLToggle<cr>", "Toggle indent guide")
leadermap("tfi", ":set foldmethod=indent<cr>", "Set foldmethod indent")
leadermap("tfm", ":set foldmethod=manual<cr>", "Set foldmethod manual")
leadermap("ts", ":setlocal spell!<cr>", "Toggle spell")
leadermap("tw", ":set wrap!<cr>", "Toggle word wrap")

-- Visual line movement (j/k move by display lines when wrap is enabled)
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('v', 'j', 'gj', { silent = true })
vim.keymap.set('v', 'k', 'gk', { silent = true })

-- Terminal window navigation
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')

-- Enable language servers here once their binaries are installed
-- (nvim-lspconfig was removed; this is the built-in API on Neovim 0.11+):
-- vim.lsp.enable({ "lua_ls", "clangd" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }

    -- hover
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- definitions
    leadermap("dc", vim.lsp.buf.declaration, "Goto declaration", opts)
    leadermap("df", vim.lsp.buf.definition, "Goto definition", opts)
    leadermap("di", vim.lsp.buf.implementation, "Goto implementation", opts)
    leadermap("dg", vim.lsp.buf.signature_help, "Signature help", opts)
    leadermap("dt", vim.lsp.buf.type_definition, "Goto type definition", opts)
    leadermap('dr', ":Trouble lsp_references toggle<cr>", "References")
    
    -- refactor
    leadermap("fr", vim.lsp.buf.rename, "Rename", opts)
    leadermap("fa", vim.lsp.buf.code_action, "Code action", opts)
    vim.keymap.set("v", "<leader>g", vim.lsp.buf.code_action, opts)

    leadermap("fs", function()
      vim.lsp.buf.format { async = true }
    end, "Format", opts)

    -- workspace
    leadermap("dwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder", opts)
    leadermap("dwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", opts)
    leadermap("dwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders", opts)

    leadermap("fq", function()
      vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = 0 }), true)
      if not vim.bo.modified then vim.cmd("edit") end -- re-fire FileType autocmds to restart servers
    end, "Restart the LSP server", opts)
  end,
})

leadermap('dd', ":Trouble diagnostics toggle<cr>", "Toggle diagnostics")
leadermap('dq', ":Trouble qflist toggle<cr>", "Open quickfix")
leadermap('dl', ":Trouble loclist toggle<cr>", "Open loclist")
leadermap('ds', ":Trouble diagnostics toggle<cr>", "Workspace diagnostics")
leadermap('da', ":Trouble diagnostics toggle filter.buf=0<cr>", "Document diagnostics")

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
