# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# tender scheme by Jacobo Tabernero (https://github/com/jacoborus/tender.vim)

function base16-tender -d "base16 tender theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "28/28/28" # Base 00 - Black
    set color01 "f4/37/53" # Base 08 - Red
    set color02 "c9/d0/5c" # Base 0B - Green
    set color03 "ff/c2/4b" # Base 0A - Yellow
    set color04 "b3/de/ef" # Base 0D - Blue
    set color05 "d3/b9/87" # Base 0E - Magenta
    set color06 "73/ce/f4" # Base 0C - Cyan
    set color07 "ee/ee/ee" # Base 05 - White
    set color08 "4c/4c/4c" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "fe/ff/ff" # Base 07 - Bright White
    set color16 "dc/96/56" # Base 09
    set color17 "a1/69/46" # Base 0F
    set color18 "38/38/38" # Base 01
    set color19 "48/48/48" # Base 02
    set color20 "b8/b8/b8" # Base 04
    set color21 "e8/e8/e8" # Base 06
    set color_foreground "ee/ee/ee" # Base 05
    set color_background "28/28/28" # Base 00

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
        __put_template_custom Pg eeeeee # foreground
        __put_template_custom Ph 282828 # background
        __put_template_custom Pi eeeeee # bold color
        __put_template_custom Pj 484848 # selection color
        __put_template_custom Pk eeeeee # selected text color
        __put_template_custom Pl eeeeee # cursor
        __put_template_custom Pm 282828 # cursor text

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
        set -gx fish_color_command "b3deef" blue
        set -gx fish_color_quote "c9d05c" green
        set -gx fish_color_redirection "ffc24b" yellow
        set -gx fish_color_end "73cef4" cyan
        set -gx fish_color_error "f43753" red
        set -gx fish_color_param "e8e8e8" cyan
        set -gx fish_color_comment "4c4c4c" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "eeeeee" white --bold --background=brblack
        set -gx fish_color_search_match "ffc24b" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "73cef4" cyan
        set -gx fish_color_escape "73cef4" cyan
        set -gx fish_color_cwd "c9d05c" green
        set -gx fish_color_cwd_root "f43753" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "4c4c4c" brblack
        set -gx fish_color_user "c9d05c" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ffc24b" yellow
        set -gx fish_pager_color_prefix "eeeeee" white --bold --underline
        set -gx fish_pager_color_progress "feffff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "28" "28" "28"
    __base16_fish_shell_create_vimrc_background tender
    set -U base16_fish_theme tender

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
