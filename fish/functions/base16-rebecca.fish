# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Rebecca scheme by Victor Borja (http://github.com/vic) based on Rebecca Theme (http://github.com/vic/rebecca-theme)

function base16-rebecca -d "base16 Rebecca theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "29/2a/44" # Base 00 - Black
    set color01 "a0/a0/c5" # Base 08 - Red
    set color02 "6d/fe/df" # Base 0B - Green
    set color03 "ae/81/ff" # Base 0A - Yellow
    set color04 "2d/e0/a7" # Base 0D - Blue
    set color05 "7a/a5/ff" # Base 0E - Magenta
    set color06 "8e/ae/e0" # Base 0C - Cyan
    set color07 "f1/ef/f8" # Base 05 - White
    set color08 "66/66/99" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "53/49/5d" # Base 07 - Bright White
    set color16 "ef/e4/a1" # Base 09
    set color17 "ff/79/c6" # Base 0F
    set color18 "66/33/99" # Base 01
    set color19 "38/3a/62" # Base 02
    set color20 "a0/a0/c5" # Base 04
    set color21 "cc/cc/ff" # Base 06
    set color_foreground "f1/ef/f8" # Base 05
    set color_background "29/2a/44" # Base 00

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
        __put_template_custom Pg f1eff8 # foreground
        __put_template_custom Ph 292a44 # background
        __put_template_custom Pi f1eff8 # bold color
        __put_template_custom Pj 383a62 # selection color
        __put_template_custom Pk f1eff8 # selected text color
        __put_template_custom Pl f1eff8 # cursor
        __put_template_custom Pm 292a44 # cursor text

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
        set -gx fish_color_command "2de0a7" blue
        set -gx fish_color_quote "6dfedf" green
        set -gx fish_color_redirection "ae81ff" yellow
        set -gx fish_color_end "8eaee0" cyan
        set -gx fish_color_error "a0a0c5" red
        set -gx fish_color_param "ccccff" cyan
        set -gx fish_color_comment "666699" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "f1eff8" white --bold --background=brblack
        set -gx fish_color_search_match "ae81ff" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "8eaee0" cyan
        set -gx fish_color_escape "8eaee0" cyan
        set -gx fish_color_cwd "6dfedf" green
        set -gx fish_color_cwd_root "a0a0c5" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "666699" brblack
        set -gx fish_color_user "6dfedf" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ae81ff" yellow
        set -gx fish_pager_color_prefix "f1eff8" white --bold --underline
        set -gx fish_pager_color_progress "53495d" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "29" "2a" "44"
    __base16_fish_shell_create_vimrc_background rebecca
    set -U base16_fish_theme rebecca

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
