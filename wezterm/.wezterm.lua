local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_schemes = {
  ["Poimandres"] = {
    foreground = "#E4F0FB",
    background = "#1B1E28",
    cursor_fg = "#1B1E28",
    cursor_bg = "#A6ACCD",
    cursor_border = "#A6ACCD",
    selection_fg = "#E4F0FB",
    selection_bg = "#506477",
    ansi = {
      "#171922", "#D0679D", "#5DE4C7", "#FFFAC2",
      "#89DDFF", "#FCC5E9", "#89DDFF", "#FFFFFF"
    },
    brights = {
      "#506477", "#D0679D", "#5DE4C7", "#FFFAC2",
      "#ADD7FF", "#FCC5E9", "#ADD7FF", "#FFFFFF"
    },
    scrollbar_thumb = "#303340",
    split = "#171922",
    visual_bell = "#506477",
    compose_cursor = "#FCC5E9",
    indexed = {
      [16] = "#5DE4C7",
      [17] = "#D0679D"
    },
    tab_bar = {
      background = "#171922",
      active_tab = {
        bg_color = "#1B1E28",
        fg_color = "#E4F0FB",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None"
      },
      inactive_tab = {
        bg_color = "#171922",
        fg_color = "#506477",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None"
      },
      inactive_tab_hover = {
        bg_color = "#171922",
        fg_color = "#767C9D",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None"
      },
      new_tab = {
        bg_color = "#171922",
        fg_color = "#506477",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None"
      },
      new_tab_hover = {
        bg_color = "#171922",
        fg_color = "#767C9D",
        intensity = "Normal",
        italic = true,
        strikethrough = false,
        underline = "None"
      }
    }
  }
}

config.color_scheme = 'Poimandres'

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
