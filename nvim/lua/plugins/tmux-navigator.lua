return {
  "christoomey/vim-tmux-navigator",
  config = function()
    vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
    vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
    vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
    vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
  end
}
