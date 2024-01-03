return {
  "christoomey/vim-tmux-navigator",
  config = function()
    vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
    vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
    vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
    vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
  end,
}
