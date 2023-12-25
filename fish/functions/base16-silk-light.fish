# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Silk Light scheme by Gabriel Fontes (https://github.com/Misterio77)

function base16-silk-light -d "base16 Silk Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "e9/f1/ef" # Base 00 - Black
    set color01 "cf/43/2e" # Base 08 - Red
    set color02 "6c/a3/8c" # Base 0B - Green
    set color03 "cf/ad/25" # Base 0A - Yellow
    set color04 "39/aa/c9" # Base 0D - Blue
    set color05 "6e/65/82" # Base 0E - Magenta
    set color06 "32/9c/a2" # Base 0C - Cyan
    set color07 "38/51/56" # Base 05 - White
    set color08 "5c/78/7b" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "d2/fa/ff" # Base 07 - Bright White
    set color16 "d2/7f/46" # Base 09
    set color17 "86/53/69" # Base 0F
    set color18 "cc/d4/d3" # Base 01
    set color19 "90/b7/b6" # Base 02
    set color20 "4b/5b/5f" # Base 04
    set color21 "0e/3c/46" # Base 06
    set color_foreground "38/51/56" # Base 05
    set color_background "e9/f1/ef" # Base 00

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
        __put_template_custom Pg 385156 # foreground
        __put_template_custom Ph e9f1ef # background
        __put_template_custom Pi 385156 # bold color
        __put_template_custom Pj 90b7b6 # selection color
        __put_template_custom Pk 385156 # selected text color
        __put_template_custom Pl 385156 # cursor
        __put_template_custom Pm e9f1ef # cursor text

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
        set -gx fish_color_command "39aac9" blue
        set -gx fish_color_quote "6ca38c" green
        set -gx fish_color_redirection "cfad25" yellow
        set -gx fish_color_end "329ca2" cyan
        set -gx fish_color_error "cf432e" red
        set -gx fish_color_param "0e3c46" cyan
        set -gx fish_color_comment "5c787b" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "385156" white --bold --background=brblack
        set -gx fish_color_search_match "cfad25" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "329ca2" cyan
        set -gx fish_color_escape "329ca2" cyan
        set -gx fish_color_cwd "6ca38c" green
        set -gx fish_color_cwd_root "cf432e" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "5c787b" brblack
        set -gx fish_color_user "6ca38c" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "cfad25" yellow
        set -gx fish_pager_color_prefix "385156" white --bold --underline
        set -gx fish_pager_color_progress "d2faff" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "e9" "f1" "ef"
    __base16_fish_shell_create_vimrc_background silk-light
    set -U base16_fish_theme silk-light

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
