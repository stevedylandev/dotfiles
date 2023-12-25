# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Rosé Pine Dawn scheme by Emilia Dunfelt &lt;sayhi@dunfelt.se&gt;

function base16-rose-pine-dawn -d "base16 Rosé Pine Dawn theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "fa/f4/ed" # Base 00 - Black
    set color01 "1f/1d/2e" # Base 08 - Red
    set color02 "d7/82/7e" # Base 0B - Green
    set color03 "ea/9d/34" # Base 0A - Yellow
    set color04 "56/94/9f" # Base 0D - Blue
    set color05 "90/7a/a9" # Base 0E - Magenta
    set color06 "28/69/83" # Base 0C - Cyan
    set color07 "57/52/79" # Base 05 - White
    set color08 "98/93/a5" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "26/23/3a" # Base 07 - Bright White
    set color16 "b4/63/7a" # Base 09
    set color17 "c5/c3/ce" # Base 0F
    set color18 "ff/fa/f3" # Base 01
    set color19 "f2/e9/de" # Base 02
    set color20 "6e/6a/86" # Base 04
    set color21 "55/51/69" # Base 06
    set color_foreground "57/52/79" # Base 05
    set color_background "fa/f4/ed" # Base 00

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
        __put_template_custom Pg 575279 # foreground
        __put_template_custom Ph faf4ed # background
        __put_template_custom Pi 575279 # bold color
        __put_template_custom Pj f2e9de # selection color
        __put_template_custom Pk 575279 # selected text color
        __put_template_custom Pl 575279 # cursor
        __put_template_custom Pm faf4ed # cursor text

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
        set -gx fish_color_command "56949f" blue
        set -gx fish_color_quote "d7827e" green
        set -gx fish_color_redirection "ea9d34" yellow
        set -gx fish_color_end "286983" cyan
        set -gx fish_color_error "1f1d2e" red
        set -gx fish_color_param "555169" cyan
        set -gx fish_color_comment "9893a5" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "575279" white --bold --background=brblack
        set -gx fish_color_search_match "ea9d34" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "286983" cyan
        set -gx fish_color_escape "286983" cyan
        set -gx fish_color_cwd "d7827e" green
        set -gx fish_color_cwd_root "1f1d2e" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "9893a5" brblack
        set -gx fish_color_user "d7827e" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ea9d34" yellow
        set -gx fish_pager_color_prefix "575279" white --bold --underline
        set -gx fish_pager_color_progress "26233a" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "fa" "f4" "ed"
    __base16_fish_shell_create_vimrc_background rose-pine-dawn
    set -U base16_fish_theme rose-pine-dawn

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
