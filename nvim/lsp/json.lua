return {
	cmd = {
		"bunx", "@biomejs/biome", "lsp-proxy"
	},
	filetypes = {
		'json',
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
