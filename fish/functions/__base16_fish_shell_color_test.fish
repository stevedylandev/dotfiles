function __base16_fish_shell_color_test -d "Util function that generates colour output"
    set ansi_mappings Black Red Green Yellow Blue Magenta Cyan White "Bright Black" "Bright Red" "Bright Green" "Bright Yellow" "Bright Blue" "Bright Magenta" "Bright Cyan" "Bright White"
    set colors base00 base08 base0B base0A base0D base0E base0C base05 base03 base08 base0B base0A base0D base0E base0C base07 base09 base0F base01 base02 base04 base06
    set non_padded_values (seq 0 21)
    set padded_seq_values (seq -w 0 21)
    set base16_colors_hex $argv

    for base16_color_hex in $base16_colors_hex
       set -l index (contains -i -- $base16_color_hex $base16_colors_hex)
        set -l base16_color $padded_seq_values[$index]
        set -q ansi_mappings[$index]; or set ansi_mappings[$index] ""
        set current_color (string replace -a / "" $base16_color)

        set block (printf "\x1b[48;5;""$non_padded_values[$index]"m___________________________)
        set foreground (printf "\x1b[38;5;""$non_padded_values[$index]"m"color$base16_color")
        printf "%s %s %s #%s %-23s %s\x1b[0m\n" $foreground $colors[$index] $current_color $base16_color_hex $ansi_mappings[$index] $block
    end
end
