# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Silk Dark scheme by Gabriel Fontes (https://github.com/Misterio77)

function base16-silk-dark -d "base16 Silk Dark theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "0e/3c/46" # Base 00 - Black
    set color01 "fb/69/53" # Base 08 - Red
    set color02 "73/d8/ad" # Base 0B - Green
    set color03 "fc/e3/80" # Base 0A - Yellow
    set color04 "46/bd/dd" # Base 0D - Blue
    set color05 "75/6b/8a" # Base 0E - Magenta
    set color06 "3f/b2/b9" # Base 0C - Cyan
    set color07 "c7/db/dd" # Base 05 - White
    set color08 "58/70/73" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "d2/fa/ff" # Base 07 - Bright White
    set color16 "fc/ab/74" # Base 09
    set color17 "9b/64/7b" # Base 0F
    set color18 "1d/49/4e" # Base 01
    set color19 "2a/50/54" # Base 02
    set color20 "9d/c8/cd" # Base 04
    set color21 "cb/f2/f7" # Base 06
    set color_foreground "c7/db/dd" # Base 05
    set color_background "0e/3c/46" # Base 00

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
        __put_template_custom Pg c7dbdd # foreground
        __put_template_custom Ph 0e3c46 # background
        __put_template_custom Pi c7dbdd # bold color
        __put_template_custom Pj 2a5054 # selection color
        __put_template_custom Pk c7dbdd # selected text color
        __put_template_custom Pl c7dbdd # cursor
        __put_template_custom Pm 0e3c46 # cursor text

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
        set -gx fish_color_command "46bddd" blue
        set -gx fish_color_quote "73d8ad" green
        set -gx fish_color_redirection "fce380" yellow
        set -gx fish_color_end "3fb2b9" cyan
        set -gx fish_color_error "fb6953" red
        set -gx fish_color_param "cbf2f7" cyan
        set -gx fish_color_comment "587073" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "c7dbdd" white --bold --background=brblack
        set -gx fish_color_search_match "fce380" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "3fb2b9" cyan
        set -gx fish_color_escape "3fb2b9" cyan
        set -gx fish_color_cwd "73d8ad" green
        set -gx fish_color_cwd_root "fb6953" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "587073" brblack
        set -gx fish_color_user "73d8ad" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "fce380" yellow
        set -gx fish_pager_color_prefix "c7dbdd" white --bold --underline
        set -gx fish_pager_color_progress "d2faff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "0e" "3c" "46"
    __base16_fish_shell_create_vimrc_background silk-dark
    set -U base16_fish_theme silk-dark

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
