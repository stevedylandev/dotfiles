# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Tango scheme by @Schnouki, based on the Tango Desktop Project

function base16-tango -d "base16 Tango theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "2e/34/36" # Base 00 - Black
    set color01 "cc/00/00" # Base 08 - Red
    set color02 "4e/9a/06" # Base 0B - Green
    set color03 "c4/a0/00" # Base 0A - Yellow
    set color04 "34/65/a4" # Base 0D - Blue
    set color05 "75/50/7b" # Base 0E - Magenta
    set color06 "06/98/9a" # Base 0C - Cyan
    set color07 "d3/d7/cf" # Base 05 - White
    set color08 "55/57/53" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ee/ee/ec" # Base 07 - Bright White
    set color16 "ef/29/29" # Base 09
    set color17 "34/e2/e2" # Base 0F
    set color18 "8a/e2/34" # Base 01
    set color19 "fc/e9/4f" # Base 02
    set color20 "72/9f/cf" # Base 04
    set color21 "ad/7f/a8" # Base 06
    set color_foreground "d3/d7/cf" # Base 05
    set color_background "2e/34/36" # Base 00

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
        __put_template_custom Pg d3d7cf # foreground
        __put_template_custom Ph 2e3436 # background
        __put_template_custom Pi d3d7cf # bold color
        __put_template_custom Pj fce94f # selection color
        __put_template_custom Pk d3d7cf # selected text color
        __put_template_custom Pl d3d7cf # cursor
        __put_template_custom Pm 2e3436 # cursor text

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
        set -gx fish_color_command "3465a4" blue
        set -gx fish_color_quote "4e9a06" green
        set -gx fish_color_redirection "c4a000" yellow
        set -gx fish_color_end "06989a" cyan
        set -gx fish_color_error "cc0000" red
        set -gx fish_color_param "ad7fa8" cyan
        set -gx fish_color_comment "555753" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "d3d7cf" white --bold --background=brblack
        set -gx fish_color_search_match "c4a000" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "06989a" cyan
        set -gx fish_color_escape "06989a" cyan
        set -gx fish_color_cwd "4e9a06" green
        set -gx fish_color_cwd_root "cc0000" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "555753" brblack
        set -gx fish_color_user "4e9a06" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "c4a000" yellow
        set -gx fish_pager_color_prefix "d3d7cf" white --bold --underline
        set -gx fish_pager_color_progress "eeeeec" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "2e" "34" "36"
    __base16_fish_shell_create_vimrc_background tango
    set -U base16_fish_theme tango

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
