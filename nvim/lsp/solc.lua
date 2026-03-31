return {
  cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
  filetypes = {
    "sol",
    "solidity"
  },
  root_markers = {
    ".gitignore",
    "foundry.toml"
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
