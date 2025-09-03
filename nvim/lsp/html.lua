return {
	cmd = {
		"vscode-html-language-server", "--stdio"
	},
	filetypes = {
		'html',
	},
	root_markers = {
		'index.js', 'index.html', 'styles.css', '.git' },
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
