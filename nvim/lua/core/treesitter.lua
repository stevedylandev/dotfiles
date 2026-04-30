-- Native treesitter parsers installed via luarocks
local rocks_path = vim.fn.stdpath("data") .. "/site/lib/luarocks/rocks-5.1"
for _, parser_dir in ipairs(vim.fn.glob(rocks_path .. "/tree-sitter-*/*/", true, true)) do
  vim.opt.runtimepath:prepend(parser_dir)
end
