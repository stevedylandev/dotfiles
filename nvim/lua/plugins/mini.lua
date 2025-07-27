return {
    'echasnovski/mini.nvim',
    version = '*',
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
                move_down = '<C-j>',
                move_up   = '<C-k>',
            },
            window = { config = win_config }
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

        require('mini.files').setup()

        require('mini.surround').setup({
            mappings = {
                replace = 'cs', -- Replace surrounding
            },
        })
        require('mini.statusline').setup()
    end
}
