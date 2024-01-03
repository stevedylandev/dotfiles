return {
	"FabijanZulj/blame.nvim",
	config = function()
		vim.keymap.set("n", "<leader>b", "<cmd>ToggleBlame virtual<CR>", {})
	end,
}
