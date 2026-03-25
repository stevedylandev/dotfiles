return {
  'echasnovski/mini.nvim',
  version = '*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local win_config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
    require("mini.pick").setup({
      mappings = {
        choose_marked = '<C-y>',
        move_down     = '<C-j>',
        move_up       = '<C-k>',
      },
      window = { config = win_config }
    })

    vim.api.nvim_set_hl(0, "MiniPickMatchCurrent",
      { bg = vim.g.terminal_color_8
      })

    require("mini.comment").setup({
      mappings = {
        comment = 'gb',
        comment_visual = 'gb',
        textobject = 'gb'
      }
    })

    require("mini.completion").setup({
      mappings = {
        scroll_down = '<C-j>',
        scroll_up = '<C-k>',
      },
    })

    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup({
      snippets = {
        gen_loader.from_lang(),
      },
    })
    MiniSnippets.start_lsp_server()

    require('mini.files').setup({
      mappings = {
        close      = '<ESC>',
        go_in_plus = '<CR>'
      }
    })

    require('mini.icons').setup()
    vim.api.nvim_set_hl(0, 'MiniIconsAzure',  { fg = vim.g.terminal_color_12 })
    vim.api.nvim_set_hl(0, 'MiniIconsBlue',   { fg = vim.g.terminal_color_4 })
    vim.api.nvim_set_hl(0, 'MiniIconsCyan',    { fg = vim.g.terminal_color_6 })
    vim.api.nvim_set_hl(0, 'MiniIconsGreen',   { fg = vim.g.terminal_color_2 })
    vim.api.nvim_set_hl(0, 'MiniIconsGrey',    { fg = vim.g.terminal_color_8 })
    vim.api.nvim_set_hl(0, 'MiniIconsOrange',  { fg = vim.g.terminal_color_3 })
    vim.api.nvim_set_hl(0, 'MiniIconsPurple',  { fg = vim.g.terminal_color_5 })
    vim.api.nvim_set_hl(0, 'MiniIconsRed',     { fg = vim.g.terminal_color_1 })
    vim.api.nvim_set_hl(0, 'MiniIconsYellow',  { fg = vim.g.terminal_color_11 })

    require('mini.surround').setup({
      mappings = {
        replace = 'cs', -- Replace surrounding
      },
    })
    require('mini.diff').setup({
      view = {
        -- Visualization style. Possible values are 'sign' and 'number'.
        -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
        -- Suppress vim.tbl_islist deprecation warning
        style = vim.go.number and 'sign' or 'number',

        -- Signs used for hunks with 'sign' view
        signs = {
          add = "+",
          change = "~",
          delete = "-",
          topdelete = "",
          changedelete = "▎",
          untracked = "+"
        },

        priority = 199,
      },

      delay = {
        text_change = 200,
      },

      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = 'gh',

        -- Reset hunks inside a visual/operator region
        reset = 'gH',

        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = 'gh',

        -- Go to hunk range in corresponding direction
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
      },

      options = {
        algorithm = 'histogram',
        indent_heuristic = true,
        linematch = 60,
        wrap_goto = false,
      },
    })
    require('mini.statusline').setup()
    require('mini.extra').setup()
  end
}
