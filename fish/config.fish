eval "$(/opt/homebrew/bin/brew shellenv)"
set -U fish_greeting
set -U fish_key_bindings fish_vi_key_bindings
set -U fish_cursor_default
set -Ux EDITOR nvim
set -Ux fish_color_autosuggestion normal
# Base16 Shell
if status --is-interactive
    set BASE16_SHELL_PATH "$HOME/.config/base16-shell"
    set BASE16_SHELL "$HOME/.config/base16-shell"
    if test -s "$BASE16_SHELL_PATH"
        source "$BASE16_SHELL_PATH/profile_helper.fish"
    end
end
zoxide init fish | source
starship init fish | source
