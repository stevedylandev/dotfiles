return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          statusline = {
            "help",
            "startify",
            "dashboard",
            "neo-tree",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "alpha",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "qf",
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          -- "filename",
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = "",
            },
          },
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "diff" },
          { "searchcount" },
        },
        lualine_x = { { "b:gitsigns_head", icon = "" } },
        lualine_y = { "progress" },
        lualine_z = {
          -- function()
          --   return " " .. os.date("%R")
          -- end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    })
  end,
}
