local current_theme_name = "black-metal-bathory"
if current_theme_name ~= "" and vim.g.colors_name ~= 'base16-' .. current_theme_name then
  vim.cmd('colorscheme base16-' .. current_theme_name)
end
