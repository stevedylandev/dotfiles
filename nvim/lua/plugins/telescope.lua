return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>sd', ":Telescope diagnostics bufnr=0<cr>", {})
    vim.keymap.set('n', "<leader>sD", "<cmd>Telescope diagnostics<cr>", {})
    vim.keymap.set('n', "<Leader>o", ":Telescope buffers theme=dropdown<CR>", {})
    vim.keymap.set('n', "<leader><leader>", ":Telescope smart_open<CR>", {})
    vim.keymap.set('n', "<leader>gc", "<cmd>Telescope git_commits<CR>", {})
    vim.keymap.set('n', "<leader>gs", "<cmd>Telescope git_status<CR>", {})
    vim.keymap.set('n', "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {})



    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      file_ignore_patterns = { "%.git/." },
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
        previewer = false,
        -- hidden = true,
        prompt_prefix = "   ",
        file_ignore_patterns = { "node_modules", "package-lock.json" },
        initial_mode = "insert",
        select_strategy = "reset",
        sorting_strategy = "ascending",
        -- layout_strategy = "horizontal",
        layout_config = {
          --   width = 0.5,
          --   height = 0.4,
          prompt_position = "top",
          preview_cutoff = 120,
        },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
          previewer = true,
          layout_config = {
            -- width = 0.5,
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        git_files = {
          previewer = true,
          layout_config = {
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<c-d>"] = actions.delete_buffer,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
            },
          },
          previewer = false,
          initial_mode = "insert",
          theme = "dropdown",
          layout_config = {
            width = 0.5,
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        current_buffer_fuzzy_find = {
          previewer = true,
          -- theme = "dropdown",
          layout_config = {
            -- width = 0.5,
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        live_grep = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        grep_string = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        lsp_references = {
          show_line = false,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        treesitter = {
          show_line = false,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            previewer = false,
            initial_mode = "normal",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          }),
        },
        frecency = {
          default_workspace = "CWD",
          show_scores = true,
          show_unindexed = true,
          disable_devicons = false,
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "*/lua-language-server/*",
          },
        },
        -- file_browser = {
        --   -- theme = "",
        --   previewer = true,
        --   -- disables netrw and use telescope-file-browser in its place
        --   hijack_netrw = true,
        --   -- mappings = {
        --   --   ["i"] = {
        --   --     -- your custom insert mode mappings
        --   --   },
        --   --   ["n"] = {
        --   --     -- your custom normal mode mappings
        --   --   },
        --   -- },
        -- },
      },
    })
    -- telescope.load_extension("file_browser")
  end,
}
