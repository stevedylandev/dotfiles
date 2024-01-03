return {
  "mvllow/modes.nvim",
  tag = "v0.2.0",
  config = function()
    require("modes").setup({
      colors = {
        copy = vim.g.terminal_color_2,
        delete = vim.g.terminal_color_1,
        visual = vim.g.terminal_color_3,
        insert = vim.g.terminal_color_6,
      },
    })
  end,
}
