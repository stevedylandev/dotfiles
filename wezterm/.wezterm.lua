local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--config.color_scheme = "Poimandres"
config.color_scheme = 'Black Metal (Bathory) (base16)'

config.font = wezterm.font('CommitMono Nerd Font')
config.font_size = 14


config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 10,
  right =10,
  top = 4,
  bottom = 4
}

config.initial_cols = 85
config.initial_rows = 30


return config
