# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Solar Flare Light scheme by Chuck Harmston (https://chuck.harmston.ch)

function base16-solarflare-light -d "base16 Solar Flare Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "f5/f7/fa" # Base 00 - Black
    set color01 "ef/52/53" # Base 08 - Red
    set color02 "7c/c8/44" # Base 0B - Green
    set color03 "e4/b5/1c" # Base 0A - Yellow
    set color04 "33/b5/e1" # Base 0D - Blue
    set color05 "a3/63/d5" # Base 0E - Magenta
    set color06 "52/cb/b0" # Base 0C - Cyan
    set color07 "58/68/75" # Base 05 - White
    set color08 "85/93/9e" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "18/26/2f" # Base 07 - Bright White
    set color16 "e6/6b/2b" # Base 09
    set color17 "d7/3c/9a" # Base 0F
    set color18 "e8/e9/ed" # Base 01
    set color19 "a6/af/b8" # Base 02
    set color20 "66/75/81" # Base 04
    set color21 "22/2e/38" # Base 06
    set color_foreground "58/68/75" # Base 05
    set color_background "f5/f7/fa" # Base 00

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
        __put_template_custom Pg 586875 # foreground
        __put_template_custom Ph f5f7fa # background
        __put_template_custom Pi 586875 # bold color
        __put_template_custom Pj a6afb8 # selection color
        __put_template_custom Pk 586875 # selected text color
        __put_template_custom Pl 586875 # cursor
        __put_template_custom Pm f5f7fa # cursor text

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
        set -gx fish_color_command "33b5e1" blue
        set -gx fish_color_quote "7cc844" green
        set -gx fish_color_redirection "e4b51c" yellow
        set -gx fish_color_end "52cbb0" cyan
        set -gx fish_color_error "ef5253" red
        set -gx fish_color_param "222e38" cyan
        set -gx fish_color_comment "85939e" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "586875" white --bold --background=brblack
        set -gx fish_color_search_match "e4b51c" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "52cbb0" cyan
        set -gx fish_color_escape "52cbb0" cyan
        set -gx fish_color_cwd "7cc844" green
        set -gx fish_color_cwd_root "ef5253" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "85939e" brblack
        set -gx fish_color_user "7cc844" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "e4b51c" yellow
        set -gx fish_pager_color_prefix "586875" white --bold --underline
        set -gx fish_pager_color_progress "18262f" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "f5" "f7" "fa"
    __base16_fish_shell_create_vimrc_background solarflare-light
    set -U base16_fish_theme solarflare-light

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
