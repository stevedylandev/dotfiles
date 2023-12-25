# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Nord scheme by arcticicestudio

function base16-nord -d "base16 Nord theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "2e/34/40" # Base 00 - Black
    set color01 "bf/61/6a" # Base 08 - Red
    set color02 "a3/be/8c" # Base 0B - Green
    set color03 "eb/cb/8b" # Base 0A - Yellow
    set color04 "81/a1/c1" # Base 0D - Blue
    set color05 "b4/8e/ad" # Base 0E - Magenta
    set color06 "88/c0/d0" # Base 0C - Cyan
    set color07 "e5/e9/f0" # Base 05 - White
    set color08 "4c/56/6a" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "8f/bc/bb" # Base 07 - Bright White
    set color16 "d0/87/70" # Base 09
    set color17 "5e/81/ac" # Base 0F
    set color18 "3b/42/52" # Base 01
    set color19 "43/4c/5e" # Base 02
    set color20 "d8/de/e9" # Base 04
    set color21 "ec/ef/f4" # Base 06
    set color_foreground "e5/e9/f0" # Base 05
    set color_background "2e/34/40" # Base 00

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
        __put_template_custom Pg e5e9f0 # foreground
        __put_template_custom Ph 2e3440 # background
        __put_template_custom Pi e5e9f0 # bold color
        __put_template_custom Pj 434c5e # selection color
        __put_template_custom Pk e5e9f0 # selected text color
        __put_template_custom Pl e5e9f0 # cursor
        __put_template_custom Pm 2e3440 # cursor text

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
        set -gx fish_color_command "81a1c1" blue
        set -gx fish_color_quote "a3be8c" green
        set -gx fish_color_redirection "ebcb8b" yellow
        set -gx fish_color_end "88c0d0" cyan
        set -gx fish_color_error "bf616a" red
        set -gx fish_color_param "eceff4" cyan
        set -gx fish_color_comment "4c566a" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "e5e9f0" white --bold --background=brblack
        set -gx fish_color_search_match "ebcb8b" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "88c0d0" cyan
        set -gx fish_color_escape "88c0d0" cyan
        set -gx fish_color_cwd "a3be8c" green
        set -gx fish_color_cwd_root "bf616a" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "4c566a" brblack
        set -gx fish_color_user "a3be8c" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ebcb8b" yellow
        set -gx fish_pager_color_prefix "e5e9f0" white --bold --underline
        set -gx fish_pager_color_progress "8fbcbb" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "2e" "34" "40"
    __base16_fish_shell_create_vimrc_background nord
    set -U base16_fish_theme nord

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
