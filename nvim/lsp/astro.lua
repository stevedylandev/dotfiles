return {
	cmd = {
		"astro-ls", "--stdio"
	},
	filetypes = {
		"astro",
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
  init_options = {
    typescript = {
      tsdk = "/Users/stevedylandev/.bun/install/global/node_modules/typescript/lib"
    },
  },
}
