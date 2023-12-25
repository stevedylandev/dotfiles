vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      require("telescope.builtin").find_files()
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("silent! lua require('colorizer').attach_to_buffer(0)")
  end,
})
