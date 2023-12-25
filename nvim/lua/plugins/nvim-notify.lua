return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>h",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = {
    render = "minimal",
    animation_style = "fade",
    background_colour = "#1E2021",
    timeout = 2000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  init = function()
    vim.notify = require("notify")
  end,
}
