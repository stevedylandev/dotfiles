local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Saving
map("n", "++", "<cmd>write!<CR>", opts)

-- Tmux Navigation
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)

-- Navigation
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<leader>o", "<cmd>Pick buffers<CR>", opts)
map("n", "<leader>c", ":bd<cr>", opts)

-- Quickfix
map("n", "<C-n>", "<cmd>cnext<CR>zz", opts)
map("n", "<C-m>", "<cmd>cprev<CR>zz", opts)
map("n", "<leader>q", "<cmd>copen<CR>", opts)
map("n", "<leader>a", "<cmd>cclose<CR>", opts)

-- Search
map("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
map("n", "<leader>f", "<cmd>Pick files<CR>", opts)
map("n", "<leader>/", "<cmd>Pick grep_live<CR>", opts)
map("n", "<leader>hh", "<cmd>Pick help<CR>", opts)

-- Diagnostics
map("n", "<leader>d", "<cmd>Pick diagnostic<CR>", opts)

-- Git
map("n", "<leader>gg", "<cmd>lua MiniDiff.toggle_overlay()<CR>", opts)

-- File explorer
map("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", opts)

-- Spelling
vim.keymap.set("n", "<leader>s", function()
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word, 25)
  MiniPick.start({
    source = {
      items = suggestions,
      name = "Spelling: " .. word,
      choose = function(item)
        vim.schedule(function()
          vim.cmd("normal! ciw" .. item)
          vim.cmd("stopinsert")
        end)
      end,
    },
  })
end, { desc = "Spelling suggestions" })

-- Editing
map("n", "J", "mzJ`z", opts)
map("n", "YY", "va{Vy", opts)
map("x", "p", '"_dP', opts)

-- Insert mode
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)
map("i", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true, silent = true })
map("i", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true, silent = true })

-- Visual mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
