# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# PhD scheme by Hennig Hasemann (http://leetless.de/vim.html)

function base16-phd -d "base16 PhD theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "06/12/29" # Base 00 - Black
    set color01 "d0/73/46" # Base 08 - Red
    set color02 "99/bf/52" # Base 0B - Green
    set color03 "fb/d4/61" # Base 0A - Yellow
    set color04 "52/99/bf" # Base 0D - Blue
    set color05 "99/89/cc" # Base 0E - Magenta
    set color06 "72/b9/bf" # Base 0C - Cyan
    set color07 "b8/bb/c2" # Base 05 - White
    set color08 "71/78/85" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ff/ff/ff" # Base 07 - Bright White
    set color16 "f0/a0/00" # Base 09
    set color17 "b0/80/60" # Base 0F
    set color18 "2a/34/48" # Base 01
    set color19 "4d/56/66" # Base 02
    set color20 "9a/99/a3" # Base 04
    set color21 "db/dd/e0" # Base 06
    set color_foreground "b8/bb/c2" # Base 05
    set color_background "06/12/29" # Base 00

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
        __put_template_custom Pg b8bbc2 # foreground
        __put_template_custom Ph 061229 # background
        __put_template_custom Pi b8bbc2 # bold color
        __put_template_custom Pj 4d5666 # selection color
        __put_template_custom Pk b8bbc2 # selected text color
        __put_template_custom Pl b8bbc2 # cursor
        __put_template_custom Pm 061229 # cursor text

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
        set -gx fish_color_command "5299bf" blue
        set -gx fish_color_quote "99bf52" green
        set -gx fish_color_redirection "fbd461" yellow
        set -gx fish_color_end "72b9bf" cyan
        set -gx fish_color_error "d07346" red
        set -gx fish_color_param "dbdde0" cyan
        set -gx fish_color_comment "717885" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "b8bbc2" white --bold --background=brblack
        set -gx fish_color_search_match "fbd461" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "72b9bf" cyan
        set -gx fish_color_escape "72b9bf" cyan
        set -gx fish_color_cwd "99bf52" green
        set -gx fish_color_cwd_root "d07346" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "717885" brblack
        set -gx fish_color_user "99bf52" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "fbd461" yellow
        set -gx fish_pager_color_prefix "b8bbc2" white --bold --underline
        set -gx fish_pager_color_progress "ffffff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "06" "12" "29"
    __base16_fish_shell_create_vimrc_background phd
    set -U base16_fish_theme phd

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
