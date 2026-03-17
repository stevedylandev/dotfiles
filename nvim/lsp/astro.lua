return {
  cmd = {
    "astro-ls", "--stdio"
  },
  filetypes = {
    "astro",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  init_options = {
    typescript = {
      tsdk = "/Users/stevedylandev/.bun/install/global/node_modules/typescript/lib"
    },
  },
}
