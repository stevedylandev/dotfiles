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
			enable_git_status = true,
			window = {
				position = "float",
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					always_show = {
						"*.env",
					},
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
