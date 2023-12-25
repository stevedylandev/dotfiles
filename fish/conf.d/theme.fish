function theme
    set currentTheme $BASE16_THEME
    exa ~/.config/base16-shell/scripts/ \
        | sed 's/base16-//; s/\.sh$//' \
        | fzf \
        --query $currentTheme \
        --preview "bash ~/.config/base16-shell/colortest base16-{}.sh" \
        --border rounded \
        --pointer '>' \
        --prompt ' '

end
