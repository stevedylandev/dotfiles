return {
	"rcarriga/nvim-notify",
	keys = {
		{
			"<leader>hh",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss all Notifications",
		},
	},
	config = function()
		require("notify").setup({
			render = "compact",
			stages = "fade",
			timeout = 500,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		})
		vim.notify = require("notify")
	end,
}
