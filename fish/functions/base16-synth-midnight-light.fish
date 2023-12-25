# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Synth Midnight Terminal Light scheme by Michaël Ball (http://github.com/michael-ball/)

function base16-synth-midnight-light -d "base16 Synth Midnight Terminal Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "dd/df/e0" # Base 00 - Black
    set color01 "b5/3b/50" # Base 08 - Red
    set color02 "06/ea/61" # Base 0B - Green
    set color03 "c9/d3/64" # Base 0A - Yellow
    set color04 "03/ae/ff" # Base 0D - Blue
    set color05 "ea/5c/e2" # Base 0E - Magenta
    set color06 "42/ff/f9" # Base 0C - Cyan
    set color07 "28/29/2a" # Base 05 - White
    set color08 "a3/a5/a6" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "05/06/08" # Base 07 - Bright White
    set color16 "ea/77/0d" # Base 09
    set color17 "cd/63/20" # Base 0F
    set color18 "cf/d1/d2" # Base 01
    set color19 "c1/c3/c4" # Base 02
    set color20 "47/48/49" # Base 04
    set color21 "1a/1b/1c" # Base 06
    set color_foreground "28/29/2a" # Base 05
    set color_background "dd/df/e0" # Base 00

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
        __put_template_custom Pg 28292a # foreground
        __put_template_custom Ph dddfe0 # background
        __put_template_custom Pi 28292a # bold color
        __put_template_custom Pj c1c3c4 # selection color
        __put_template_custom Pk 28292a # selected text color
        __put_template_custom Pl 28292a # cursor
        __put_template_custom Pm dddfe0 # cursor text

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
        set -gx fish_color_command "03aeff" blue
        set -gx fish_color_quote "06ea61" green
        set -gx fish_color_redirection "c9d364" yellow
        set -gx fish_color_end "42fff9" cyan
        set -gx fish_color_error "b53b50" red
        set -gx fish_color_param "1a1b1c" cyan
        set -gx fish_color_comment "a3a5a6" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "28292a" white --bold --background=brblack
        set -gx fish_color_search_match "c9d364" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "42fff9" cyan
        set -gx fish_color_escape "42fff9" cyan
        set -gx fish_color_cwd "06ea61" green
        set -gx fish_color_cwd_root "b53b50" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "a3a5a6" brblack
        set -gx fish_color_user "06ea61" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "c9d364" yellow
        set -gx fish_pager_color_prefix "28292a" white --bold --underline
        set -gx fish_pager_color_progress "050608" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "dd" "df" "e0"
    __base16_fish_shell_create_vimrc_background synth-midnight-light
    set -U base16_fish_theme synth-midnight-light

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
