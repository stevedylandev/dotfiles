return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		local opts = { noremap = true, silent = true }
		local map = vim.api.nvim_set_keymap
		map("n", "<leader>e", ":Neotree toggle<CR>", opts)
        require("neo-tree").setup({
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    })
	end,
}
