# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Materia scheme by Defman21

function base16-materia -d "base16 Materia theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "26/32/38" # Base 00 - Black
    set color01 "ec/5f/67" # Base 08 - Red
    set color02 "8b/d6/49" # Base 0B - Green
    set color03 "ff/cc/00" # Base 0A - Yellow
    set color04 "89/dd/ff" # Base 0D - Blue
    set color05 "82/aa/ff" # Base 0E - Magenta
    set color06 "80/cb/c4" # Base 0C - Cyan
    set color07 "cd/d3/de" # Base 05 - White
    set color08 "70/78/80" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ff/ff/ff" # Base 07 - Bright White
    set color16 "ea/95/60" # Base 09
    set color17 "ec/5f/67" # Base 0F
    set color18 "2c/39/3f" # Base 01
    set color19 "37/47/4f" # Base 02
    set color20 "c9/cc/d3" # Base 04
    set color21 "d5/db/e5" # Base 06
    set color_foreground "cd/d3/de" # Base 05
    set color_background "26/32/38" # Base 00

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
        __put_template_custom Pg cdd3de # foreground
        __put_template_custom Ph 263238 # background
        __put_template_custom Pi cdd3de # bold color
        __put_template_custom Pj 37474f # selection color
        __put_template_custom Pk cdd3de # selected text color
        __put_template_custom Pl cdd3de # cursor
        __put_template_custom Pm 263238 # cursor text

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
        set -gx fish_color_command "89ddff" blue
        set -gx fish_color_quote "8bd649" green
        set -gx fish_color_redirection "ffcc00" yellow
        set -gx fish_color_end "80cbc4" cyan
        set -gx fish_color_error "ec5f67" red
        set -gx fish_color_param "d5dbe5" cyan
        set -gx fish_color_comment "707880" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "cdd3de" white --bold --background=brblack
        set -gx fish_color_search_match "ffcc00" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "80cbc4" cyan
        set -gx fish_color_escape "80cbc4" cyan
        set -gx fish_color_cwd "8bd649" green
        set -gx fish_color_cwd_root "ec5f67" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "707880" brblack
        set -gx fish_color_user "8bd649" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ffcc00" yellow
        set -gx fish_pager_color_prefix "cdd3de" white --bold --underline
        set -gx fish_pager_color_progress "ffffff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "26" "32" "38"
    __base16_fish_shell_create_vimrc_background materia
    set -U base16_fish_theme materia

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
