# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Monokai scheme by Wimer Hazenberg (http://www.monokai.nl)

function base16-monokai -d "base16 Monokai theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "27/28/22" # Base 00 - Black
    set color01 "f9/26/72" # Base 08 - Red
    set color02 "a6/e2/2e" # Base 0B - Green
    set color03 "f4/bf/75" # Base 0A - Yellow
    set color04 "66/d9/ef" # Base 0D - Blue
    set color05 "ae/81/ff" # Base 0E - Magenta
    set color06 "a1/ef/e4" # Base 0C - Cyan
    set color07 "f8/f8/f2" # Base 05 - White
    set color08 "75/71/5e" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "f9/f8/f5" # Base 07 - Bright White
    set color16 "fd/97/1f" # Base 09
    set color17 "cc/66/33" # Base 0F
    set color18 "38/38/30" # Base 01
    set color19 "49/48/3e" # Base 02
    set color20 "a5/9f/85" # Base 04
    set color21 "f5/f4/f1" # Base 06
    set color_foreground "f8/f8/f2" # Base 05
    set color_background "27/28/22" # Base 00

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
        __put_template_custom Pg f8f8f2 # foreground
        __put_template_custom Ph 272822 # background
        __put_template_custom Pi f8f8f2 # bold color
        __put_template_custom Pj 49483e # selection color
        __put_template_custom Pk f8f8f2 # selected text color
        __put_template_custom Pl f8f8f2 # cursor
        __put_template_custom Pm 272822 # cursor text

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
        set -gx fish_color_command "66d9ef" blue
        set -gx fish_color_quote "a6e22e" green
        set -gx fish_color_redirection "f4bf75" yellow
        set -gx fish_color_end "a1efe4" cyan
        set -gx fish_color_error "f92672" red
        set -gx fish_color_param "f5f4f1" cyan
        set -gx fish_color_comment "75715e" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "f8f8f2" white --bold --background=brblack
        set -gx fish_color_search_match "f4bf75" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "a1efe4" cyan
        set -gx fish_color_escape "a1efe4" cyan
        set -gx fish_color_cwd "a6e22e" green
        set -gx fish_color_cwd_root "f92672" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "75715e" brblack
        set -gx fish_color_user "a6e22e" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "f4bf75" yellow
        set -gx fish_pager_color_prefix "f8f8f2" white --bold --underline
        set -gx fish_pager_color_progress "f9f8f5" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "27" "28" "22"
    __base16_fish_shell_create_vimrc_background monokai
    set -U base16_fish_theme monokai

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
