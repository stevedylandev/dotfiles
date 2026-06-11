vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.opt.swapfile = false
vim.opt.autowrite = true           -- Enable auto write
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3           -- Hide * markup for bold and italic
vim.opt.confirm = true             -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true          -- Enable highlighting of the current line
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.incsearch = true
vim.opt.laststatus = 3         -- global statusline
vim.opt.list = false           -- Don't show invisible characters
vim.opt.mouse = "a"            -- Enable mouse mode
vim.opt.number = true          -- Print line number
vim.opt.pumblend = 10          -- Popup blend
vim.opt.pumheight = 10         -- Maximum number of entries in a popup
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.scrolloff = 4          -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true      -- Round indent
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false       -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8      -- Columns of context
vim.opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true       -- Don't ignore case with capitals
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true      -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true      -- Put new windows right of current
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.termguicolors = true   -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5                -- Minimum window width
vim.opt.wrap = false                   -- Disable line wrap
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.shell = "sh"
vim.opt.smoothscroll = true

-- Treesitter folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.filetype.add({ extension = { mdx = "mdx", }, })
vim.treesitter.language.register("markdown", "mdx")

