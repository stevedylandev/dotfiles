-- Suppress vim.tbl_islist deprecation warning
local original_deprecate = vim.deprecate
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  if name == "vim.tbl_islist" then
    return
  end
  return original_deprecate(name, alternative, version, plugin, backtrace)
end

require("config.options")
require("core.lazy")
require("core.lsp")
require("config.keymaps")
require("config.autocmds")
