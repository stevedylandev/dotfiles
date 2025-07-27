return {
	cmd = {
		"asm-lsp",
	},
	filetypes = {
		"s",
		"S",
		"asm"
	},
	-- settings = {
	--     Lua = {
	--         diagnostics = {
	--             --     disable = { "missing-parameters", "missing-fields" },
	--         },
	--     },
	-- },

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
