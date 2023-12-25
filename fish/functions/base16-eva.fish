# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Eva scheme by kjakapat (https://github.com/kjakapat)

function base16-eva -d "base16 Eva theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "2a/3b/4d" # Base 00 - Black
    set color01 "c4/67/6c" # Base 08 - Red
    set color02 "66/ff/66" # Base 0B - Green
    set color03 "ff/ff/66" # Base 0A - Yellow
    set color04 "15/f4/ee" # Base 0D - Blue
    set color05 "9c/6c/d3" # Base 0E - Magenta
    set color06 "4b/8f/77" # Base 0C - Cyan
    set color07 "9f/a2/a6" # Base 05 - White
    set color08 "55/79/9c" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ff/ff/ff" # Base 07 - Bright White
    set color16 "ff/99/66" # Base 09
    set color17 "bb/64/a9" # Base 0F
    set color18 "3d/56/6f" # Base 01
    set color19 "4b/69/88" # Base 02
    set color20 "7e/90/a3" # Base 04
    set color21 "d6/d7/d9" # Base 06
    set color_foreground "9f/a2/a6" # Base 05
    set color_background "2a/3b/4d" # Base 00

    # 16 color space
    __put_template 0  $color00
    __put_template 1  $color01
    __put_template 2  $color02
    __put_template 3  $color03
    __put_template 4  $color04
    __put_template 5  $color05
    __put_template 6  $color06
    __put_template 7  $color07
    __put_template 8  $color08
    __put_template 9  $color09
    __put_template 10 $color10
    __put_template 11 $color11
    __put_template 12 $color12
    __put_template 13 $color13
    __put_template 14 $color14
    __put_template 15 $color15

    # 256 color space
    __put_template 16 $color16
    __put_template 17 $color17
    __put_template 18 $color18
    __put_template 19 $color19
    __put_template 20 $color20
    __put_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
        # iTerm2 proprietary escape codes
        __put_template_custom Pg 9fa2a6 # foreground
        __put_template_custom Ph 2a3b4d # background
        __put_template_custom Pi 9fa2a6 # bold color
        __put_template_custom Pj 4b6988 # selection color
        __put_template_custom Pk 9fa2a6 # selected text color
        __put_template_custom Pl 9fa2a6 # cursor
        __put_template_custom Pm 2a3b4d # cursor text

    else
        __put_template_var 10 $color_foreground
        if test "$BASE16_SHELL_SET_BACKGROUND" != false
            __put_template_var 11 $color_background
            if string match -q -- '*rxvt*' $TERM
                __put_template_var 708 $color_background # internal border (rxvt)
            end
        end
        __put_template_custom 12 ";7" # cursor (reverse video)
    end

    if test -z $base16_fish_shell_disable_prompt_colors
        set -gx fish_color_normal normal
        set -gx fish_color_command "15f4ee" blue
        set -gx fish_color_quote "66ff66" green
        set -gx fish_color_redirection "ffff66" yellow
        set -gx fish_color_end "4b8f77" cyan
        set -gx fish_color_error "c4676c" red
        set -gx fish_color_param "d6d7d9" cyan
        set -gx fish_color_comment "55799c" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "9fa2a6" white --bold --background=brblack
        set -gx fish_color_search_match "ffff66" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "4b8f77" cyan
        set -gx fish_color_escape "4b8f77" cyan
        set -gx fish_color_cwd "66ff66" green
        set -gx fish_color_cwd_root "c4676c" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "55799c" brblack
        set -gx fish_color_user "66ff66" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ffff66" yellow
        set -gx fish_pager_color_prefix "9fa2a6" white --bold --underline
        set -gx fish_pager_color_progress "ffffff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "2a" "3b" "4d"
    __base16_fish_shell_create_vimrc_background eva
    set -U base16_fish_theme eva

    if test -n "$_flag_t"
        set base16_colors_hex
        set padded_seq_values (seq -w 0 21)
        for seq_value in $padded_seq_values
            set -l color "color$seq_value"
            set base16_colors_hex $base16_colors_hex (string replace -a / "" $$color)
        end

        __base16_fish_shell_color_test $base16_colors_hex
    end
end
