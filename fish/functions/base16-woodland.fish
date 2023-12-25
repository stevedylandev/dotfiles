# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Woodland scheme by Jay Cornwall (https://jcornwall.com)

function base16-woodland -d "base16 Woodland theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "23/1e/18" # Base 00 - Black
    set color01 "d3/5c/5c" # Base 08 - Red
    set color02 "b7/ba/53" # Base 0B - Green
    set color03 "e0/ac/16" # Base 0A - Yellow
    set color04 "88/a4/d3" # Base 0D - Blue
    set color05 "bb/90/e2" # Base 0E - Magenta
    set color06 "6e/b9/58" # Base 0C - Cyan
    set color07 "ca/bc/b1" # Base 05 - White
    set color08 "9d/8b/70" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "e4/d4/c8" # Base 07 - Bright White
    set color16 "ca/7f/32" # Base 09
    set color17 "b4/93/68" # Base 0F
    set color18 "30/2b/25" # Base 01
    set color19 "48/41/3a" # Base 02
    set color20 "b4/a4/90" # Base 04
    set color21 "d7/c8/bc" # Base 06
    set color_foreground "ca/bc/b1" # Base 05
    set color_background "23/1e/18" # Base 00

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
        __put_template_custom Pg cabcb1 # foreground
        __put_template_custom Ph 231e18 # background
        __put_template_custom Pi cabcb1 # bold color
        __put_template_custom Pj 48413a # selection color
        __put_template_custom Pk cabcb1 # selected text color
        __put_template_custom Pl cabcb1 # cursor
        __put_template_custom Pm 231e18 # cursor text

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
        set -gx fish_color_command "88a4d3" blue
        set -gx fish_color_quote "b7ba53" green
        set -gx fish_color_redirection "e0ac16" yellow
        set -gx fish_color_end "6eb958" cyan
        set -gx fish_color_error "d35c5c" red
        set -gx fish_color_param "d7c8bc" cyan
        set -gx fish_color_comment "9d8b70" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "cabcb1" white --bold --background=brblack
        set -gx fish_color_search_match "e0ac16" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "6eb958" cyan
        set -gx fish_color_escape "6eb958" cyan
        set -gx fish_color_cwd "b7ba53" green
        set -gx fish_color_cwd_root "d35c5c" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "9d8b70" brblack
        set -gx fish_color_user "b7ba53" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "e0ac16" yellow
        set -gx fish_pager_color_prefix "cabcb1" white --bold --underline
        set -gx fish_pager_color_progress "e4d4c8" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "23" "1e" "18"
    __base16_fish_shell_create_vimrc_background woodland
    set -U base16_fish_theme woodland

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
