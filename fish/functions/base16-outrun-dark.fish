# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Outrun Dark scheme by Hugo Delahousse (http://github.com/hugodelahousse/)

function base16-outrun-dark -d "base16 Outrun Dark theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "00/00/2a" # Base 00 - Black
    set color01 "ff/42/42" # Base 08 - Red
    set color02 "59/f1/76" # Base 0B - Green
    set color03 "f3/e8/77" # Base 0A - Yellow
    set color04 "66/b0/ff" # Base 0D - Blue
    set color05 "f1/05/96" # Base 0E - Magenta
    set color06 "0e/f0/f0" # Base 0C - Cyan
    set color07 "d0/d0/fa" # Base 05 - White
    set color08 "50/50/7a" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "f5/f5/ff" # Base 07 - Bright White
    set color16 "fc/8d/28" # Base 09
    set color17 "f0/03/ef" # Base 0F
    set color18 "20/20/4a" # Base 01
    set color19 "30/30/5a" # Base 02
    set color20 "b0/b0/da" # Base 04
    set color21 "e0/e0/ff" # Base 06
    set color_foreground "d0/d0/fa" # Base 05
    set color_background "00/00/2a" # Base 00

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
        __put_template_custom Pg d0d0fa # foreground
        __put_template_custom Ph 00002a # background
        __put_template_custom Pi d0d0fa # bold color
        __put_template_custom Pj 30305a # selection color
        __put_template_custom Pk d0d0fa # selected text color
        __put_template_custom Pl d0d0fa # cursor
        __put_template_custom Pm 00002a # cursor text

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
        set -gx fish_color_command "66b0ff" blue
        set -gx fish_color_quote "59f176" green
        set -gx fish_color_redirection "f3e877" yellow
        set -gx fish_color_end "0ef0f0" cyan
        set -gx fish_color_error "ff4242" red
        set -gx fish_color_param "e0e0ff" cyan
        set -gx fish_color_comment "50507a" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "d0d0fa" white --bold --background=brblack
        set -gx fish_color_search_match "f3e877" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "0ef0f0" cyan
        set -gx fish_color_escape "0ef0f0" cyan
        set -gx fish_color_cwd "59f176" green
        set -gx fish_color_cwd_root "ff4242" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "50507a" brblack
        set -gx fish_color_user "59f176" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "f3e877" yellow
        set -gx fish_pager_color_prefix "d0d0fa" white --bold --underline
        set -gx fish_pager_color_progress "f5f5ff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "00" "00" "2a"
    __base16_fish_shell_create_vimrc_background outrun-dark
    set -U base16_fish_theme outrun-dark

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
