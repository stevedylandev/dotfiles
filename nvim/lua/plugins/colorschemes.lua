return {
	"stevedylandev/ansi-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "ansi"
	end,
}
