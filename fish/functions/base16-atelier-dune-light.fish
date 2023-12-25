# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Atelier Dune Light scheme by Bram de Haan (http://atelierbramdehaan.nl)

function base16-atelier-dune-light -d "base16 Atelier Dune Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "fe/fb/ec" # Base 00 - Black
    set color01 "d7/37/37" # Base 08 - Red
    set color02 "60/ac/39" # Base 0B - Green
    set color03 "ae/95/13" # Base 0A - Yellow
    set color04 "66/84/e1" # Base 0D - Blue
    set color05 "b8/54/d4" # Base 0E - Magenta
    set color06 "1f/ad/83" # Base 0C - Cyan
    set color07 "6e/6b/5e" # Base 05 - White
    set color08 "99/95/80" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "20/20/1d" # Base 07 - Bright White
    set color16 "b6/56/11" # Base 09
    set color17 "d4/35/52" # Base 0F
    set color18 "e8/e4/cf" # Base 01
    set color19 "a6/a2/8c" # Base 02
    set color20 "7d/7a/68" # Base 04
    set color21 "29/28/24" # Base 06
    set color_foreground "6e/6b/5e" # Base 05
    set color_background "fe/fb/ec" # Base 00

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
        __put_template_custom Pg 6e6b5e # foreground
        __put_template_custom Ph fefbec # background
        __put_template_custom Pi 6e6b5e # bold color
        __put_template_custom Pj a6a28c # selection color
        __put_template_custom Pk 6e6b5e # selected text color
        __put_template_custom Pl 6e6b5e # cursor
        __put_template_custom Pm fefbec # cursor text

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
        set -gx fish_color_command "6684e1" blue
        set -gx fish_color_quote "60ac39" green
        set -gx fish_color_redirection "ae9513" yellow
        set -gx fish_color_end "1fad83" cyan
        set -gx fish_color_error "d73737" red
        set -gx fish_color_param "292824" cyan
        set -gx fish_color_comment "999580" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "6e6b5e" white --bold --background=brblack
        set -gx fish_color_search_match "ae9513" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "1fad83" cyan
        set -gx fish_color_escape "1fad83" cyan
        set -gx fish_color_cwd "60ac39" green
        set -gx fish_color_cwd_root "d73737" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "999580" brblack
        set -gx fish_color_user "60ac39" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ae9513" yellow
        set -gx fish_pager_color_prefix "6e6b5e" white --bold --underline
        set -gx fish_pager_color_progress "20201d" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "fe" "fb" "ec"
    __base16_fish_shell_create_vimrc_background atelier-dune-light
    set -U base16_fish_theme atelier-dune-light

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
