local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Compline'
config.color_schemes = {
  ["Compline"] = {
    foreground = "#f0efeb",
    background = "#1a1d21",
    cursor_fg = "#1a1d21",
    cursor_bg = "#d4ccb4",
    cursor_border = "#d4ccb4",
    selection_fg = "#f0efeb",
    selection_bg = "#3d424a",
    ansi = {
      "#22262b", "#cdacac", "#b8c4b8", "#d4ccb4",
      "#b4bcc4", "#ccc4b4", "#b4c0c8", "#8b919a"
    },
    brights = {
      "#515761", "#cdacac", "#b8c4b8", "#d4ccb4",
      "#b4bcc4", "#ccc4b4", "#b4c0c8", "#e0dcd4"
    }
  }
}

-- config.color_scheme = "Poimandres"
-- config.color_scheme = 'Darkmatter'
-- config.color_schemes = {
--   ["Darkmatter"] = {
--     foreground = "#ffffff",
--     background = "#121113",
--     cursor_fg = "#121113",
--     cursor_bg = "#ffffff",
--     cursor_border = "#ffffff",
--     selection_fg = "#000000",
--     selection_bg = "#222222",
--     ansi = {
--       "#121113", "#5f8787", "#fbcb97", "#e78a53",
--       "#888888", "#999999", "#aaaaaa", "#c1c1c1"
--     },
--     brights = {
--       "#333333", "#5f8787", "#fbcb97", "#e78a53",
--       "#888888", "#999999", "#aaaaaa", "#c1c1c1"
--     }
--   }
-- }

config.font = wezterm.font('BerkeleyMono Nerd Font')
config.font_size = 14


config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 10,
  right = 10,
  top = 4,
  bottom = 4
}

config.initial_cols = 85
config.initial_rows = 30

-- config.default_prog = { '/opt/homebrew/bin/nu' }



return config
