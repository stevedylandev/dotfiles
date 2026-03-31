return {
	cmd = {
		"asm-lsp",
	},
	filetypes = {
		"s",
		"S",
		"asm"
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
