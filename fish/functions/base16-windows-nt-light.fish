# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Windows NT Light scheme by Fergus Collins (https://github.com/C-Fergus)

function base16-windows-nt-light -d "base16 Windows NT Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "ff/ff/ff" # Base 00 - Black
    set color01 "80/00/00" # Base 08 - Red
    set color02 "00/80/00" # Base 0B - Green
    set color03 "80/80/00" # Base 0A - Yellow
    set color04 "00/00/80" # Base 0D - Blue
    set color05 "80/00/80" # Base 0E - Magenta
    set color06 "00/80/80" # Base 0C - Cyan
    set color07 "80/80/80" # Base 05 - White
    set color08 "c0/c0/c0" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "00/00/00" # Base 07 - Bright White
    set color16 "ff/ff/00" # Base 09
    set color17 "00/ff/00" # Base 0F
    set color18 "ea/ea/ea" # Base 01
    set color19 "d5/d5/d5" # Base 02
    set color20 "a0/a0/a0" # Base 04
    set color21 "40/40/40" # Base 06
    set color_foreground "80/80/80" # Base 05
    set color_background "ff/ff/ff" # Base 00

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
        __put_template_custom Pg 808080 # foreground
        __put_template_custom Ph ffffff # background
        __put_template_custom Pi 808080 # bold color
        __put_template_custom Pj d5d5d5 # selection color
        __put_template_custom Pk 808080 # selected text color
        __put_template_custom Pl 808080 # cursor
        __put_template_custom Pm ffffff # cursor text

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
        set -gx fish_color_command "000080" blue
        set -gx fish_color_quote "008000" green
        set -gx fish_color_redirection "808000" yellow
        set -gx fish_color_end "008080" cyan
        set -gx fish_color_error "800000" red
        set -gx fish_color_param "404040" cyan
        set -gx fish_color_comment "c0c0c0" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "808080" white --bold --background=brblack
        set -gx fish_color_search_match "808000" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "008080" cyan
        set -gx fish_color_escape "008080" cyan
        set -gx fish_color_cwd "008000" green
        set -gx fish_color_cwd_root "800000" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "c0c0c0" brblack
        set -gx fish_color_user "008000" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "808000" yellow
        set -gx fish_pager_color_prefix "808080" white --bold --underline
        set -gx fish_pager_color_progress "000000" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "ff" "ff" "ff"
    __base16_fish_shell_create_vimrc_background windows-nt-light
    set -U base16_fish_theme windows-nt-light

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
