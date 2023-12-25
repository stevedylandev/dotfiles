# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Darktooth scheme by Jason Milkins (https://github.com/jasonm23)

function base16-darktooth -d "base16 Darktooth theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "1d/20/21" # Base 00 - Black
    set color01 "fb/54/3f" # Base 08 - Red
    set color02 "95/c0/85" # Base 0B - Green
    set color03 "fa/c0/3b" # Base 0A - Yellow
    set color04 "0d/66/78" # Base 0D - Blue
    set color05 "8f/46/73" # Base 0E - Magenta
    set color06 "8b/a5/9b" # Base 0C - Cyan
    set color07 "a8/99/84" # Base 05 - White
    set color08 "66/5c/54" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "fd/f4/c1" # Base 07 - Bright White
    set color16 "fe/86/25" # Base 09
    set color17 "a8/73/22" # Base 0F
    set color18 "32/30/2f" # Base 01
    set color19 "50/49/45" # Base 02
    set color20 "92/83/74" # Base 04
    set color21 "d5/c4/a1" # Base 06
    set color_foreground "a8/99/84" # Base 05
    set color_background "1d/20/21" # Base 00

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
        __put_template_custom Pg a89984 # foreground
        __put_template_custom Ph 1d2021 # background
        __put_template_custom Pi a89984 # bold color
        __put_template_custom Pj 504945 # selection color
        __put_template_custom Pk a89984 # selected text color
        __put_template_custom Pl a89984 # cursor
        __put_template_custom Pm 1d2021 # cursor text

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
        set -gx fish_color_command "0d6678" blue
        set -gx fish_color_quote "95c085" green
        set -gx fish_color_redirection "fac03b" yellow
        set -gx fish_color_end "8ba59b" cyan
        set -gx fish_color_error "fb543f" red
        set -gx fish_color_param "d5c4a1" cyan
        set -gx fish_color_comment "665c54" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "a89984" white --bold --background=brblack
        set -gx fish_color_search_match "fac03b" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "8ba59b" cyan
        set -gx fish_color_escape "8ba59b" cyan
        set -gx fish_color_cwd "95c085" green
        set -gx fish_color_cwd_root "fb543f" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "665c54" brblack
        set -gx fish_color_user "95c085" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "fac03b" yellow
        set -gx fish_pager_color_prefix "a89984" white --bold --underline
        set -gx fish_pager_color_progress "fdf4c1" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "1d" "20" "21"
    __base16_fish_shell_create_vimrc_background darktooth
    set -U base16_fish_theme darktooth

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
