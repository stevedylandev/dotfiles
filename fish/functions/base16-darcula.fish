# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Darcula scheme by jetbrains

function base16-darcula -d "base16 Darcula theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "2b/2b/2b" # Base 00 - Black
    set color01 "4e/ad/e5" # Base 08 - Red
    set color02 "6a/87/59" # Base 0B - Green
    set color03 "bb/b5/29" # Base 0A - Yellow
    set color04 "98/76/aa" # Base 0D - Blue
    set color05 "cc/78/32" # Base 0E - Magenta
    set color06 "62/97/55" # Base 0C - Cyan
    set color07 "a9/b7/c6" # Base 05 - White
    set color08 "60/63/66" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ff/ff/ff" # Base 07 - Bright White
    set color16 "68/97/57" # Base 09
    set color17 "80/80/80" # Base 0F
    set color18 "32/32/32" # Base 01
    set color19 "32/32/32" # Base 02
    set color20 "a4/a3/a3" # Base 04
    set color21 "ff/c6/6d" # Base 06
    set color_foreground "a9/b7/c6" # Base 05
    set color_background "2b/2b/2b" # Base 00

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
        __put_template_custom Pg a9b7c6 # foreground
        __put_template_custom Ph 2b2b2b # background
        __put_template_custom Pi a9b7c6 # bold color
        __put_template_custom Pj 323232 # selection color
        __put_template_custom Pk a9b7c6 # selected text color
        __put_template_custom Pl a9b7c6 # cursor
        __put_template_custom Pm 2b2b2b # cursor text

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
        set -gx fish_color_command "9876aa" blue
        set -gx fish_color_quote "6a8759" green
        set -gx fish_color_redirection "bbb529" yellow
        set -gx fish_color_end "629755" cyan
        set -gx fish_color_error "4eade5" red
        set -gx fish_color_param "ffc66d" cyan
        set -gx fish_color_comment "606366" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "a9b7c6" white --bold --background=brblack
        set -gx fish_color_search_match "bbb529" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "629755" cyan
        set -gx fish_color_escape "629755" cyan
        set -gx fish_color_cwd "6a8759" green
        set -gx fish_color_cwd_root "4eade5" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "606366" brblack
        set -gx fish_color_user "6a8759" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "bbb529" yellow
        set -gx fish_pager_color_prefix "a9b7c6" white --bold --underline
        set -gx fish_pager_color_progress "ffffff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "2b" "2b" "2b"
    __base16_fish_shell_create_vimrc_background darcula
    set -U base16_fish_theme darcula

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
