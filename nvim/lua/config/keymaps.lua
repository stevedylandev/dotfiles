local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- format
-- Fast saving
map("n", "++", "<cmd>write!<CR>", opts)

-- Some useful quickfix shortcuts for quickfix
map("n", "<C-n>", "<cmd>cnext<CR>zz", opts)
map("n", "<C-m>", "<cmd>cprev<CR>zz", opts)
map("n", "<leader>a", "<cmd>cclose<CR>", opts)

-- Exit on jj and jk
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Exit on jj and jk
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)

-- Remove search highlight
map("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Grab text between curly braces
map("n", "YY", "va{Vy", opts)

-- goodies
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "J", "mzJ`z", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
map("x", "p", '"_dP', opts)

-- Better split switching
-- map("n", "<C-h>", "<C-w>h", opts)
-- map("n", "<C-j>", "<C-w>j", opts)
-- map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "<C-l>", "<C-w>l", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Visually select lines, and move them up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

map("n", "<leader>c", ":bd<cr>", opts)
