return {
	cmd = {
		"rust-analyzer",
	},
	filetypes = {
		"rust",
	},
	root_markers = {
		"Cargo.toml",
		"Cargo.lock",
		".git",
	},
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			-- Add other rust-analyzer specific settings here
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			procMacro = {
				enable = true,
				ignored = {
					leptos_macro = {
						-- "component",
						"server",
					},
				},
			},
		},
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
