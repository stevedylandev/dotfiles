# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# pinky scheme by Benjamin (https://github.com/b3nj5m1n)

function base16-pinky -d "base16 pinky theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "17/15/17" # Base 00 - Black
    set color01 "ff/a6/00" # Base 08 - Red
    set color02 "ff/00/66" # Base 0B - Green
    set color03 "20/df/6c" # Base 0A - Yellow
    set color04 "00/ff/ff" # Base 0D - Blue
    set color05 "00/7f/ff" # Base 0E - Magenta
    set color06 "66/00/ff" # Base 0C - Cyan
    set color07 "f5/f5/f5" # Base 05 - White
    set color08 "38/33/38" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "f7/f3/f7" # Base 07 - Bright White
    set color16 "00/ff/66" # Base 09
    set color17 "df/20/6c" # Base 0F
    set color18 "1b/18/1b" # Base 01
    set color19 "1d/1b/1d" # Base 02
    set color20 "e7/db/db" # Base 04
    set color21 "ff/ff/ff" # Base 06
    set color_foreground "f5/f5/f5" # Base 05
    set color_background "17/15/17" # Base 00

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
        __put_template_custom Pg f5f5f5 # foreground
        __put_template_custom Ph 171517 # background
        __put_template_custom Pi f5f5f5 # bold color
        __put_template_custom Pj 1d1b1d # selection color
        __put_template_custom Pk f5f5f5 # selected text color
        __put_template_custom Pl f5f5f5 # cursor
        __put_template_custom Pm 171517 # cursor text

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
        set -gx fish_color_command "00ffff" blue
        set -gx fish_color_quote "ff0066" green
        set -gx fish_color_redirection "20df6c" yellow
        set -gx fish_color_end "6600ff" cyan
        set -gx fish_color_error "ffa600" red
        set -gx fish_color_param "ffffff" cyan
        set -gx fish_color_comment "383338" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "f5f5f5" white --bold --background=brblack
        set -gx fish_color_search_match "20df6c" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "6600ff" cyan
        set -gx fish_color_escape "6600ff" cyan
        set -gx fish_color_cwd "ff0066" green
        set -gx fish_color_cwd_root "ffa600" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "383338" brblack
        set -gx fish_color_user "ff0066" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "20df6c" yellow
        set -gx fish_pager_color_prefix "f5f5f5" white --bold --underline
        set -gx fish_pager_color_progress "f7f3f7" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "17" "15" "17"
    __base16_fish_shell_create_vimrc_background pinky
    set -U base16_fish_theme pinky

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
