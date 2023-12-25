# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Ocean scheme by Chris Kempson (http://chriskempson.com)

function base16-ocean -d "base16 Ocean theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "2b/30/3b" # Base 00 - Black
    set color01 "bf/61/6a" # Base 08 - Red
    set color02 "a3/be/8c" # Base 0B - Green
    set color03 "eb/cb/8b" # Base 0A - Yellow
    set color04 "8f/a1/b3" # Base 0D - Blue
    set color05 "b4/8e/ad" # Base 0E - Magenta
    set color06 "96/b5/b4" # Base 0C - Cyan
    set color07 "c0/c5/ce" # Base 05 - White
    set color08 "65/73/7e" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ef/f1/f5" # Base 07 - Bright White
    set color16 "d0/87/70" # Base 09
    set color17 "ab/79/67" # Base 0F
    set color18 "34/3d/46" # Base 01
    set color19 "4f/5b/66" # Base 02
    set color20 "a7/ad/ba" # Base 04
    set color21 "df/e1/e8" # Base 06
    set color_foreground "c0/c5/ce" # Base 05
    set color_background "2b/30/3b" # Base 00

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
        __put_template_custom Pg c0c5ce # foreground
        __put_template_custom Ph 2b303b # background
        __put_template_custom Pi c0c5ce # bold color
        __put_template_custom Pj 4f5b66 # selection color
        __put_template_custom Pk c0c5ce # selected text color
        __put_template_custom Pl c0c5ce # cursor
        __put_template_custom Pm 2b303b # cursor text

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
        set -gx fish_color_command "8fa1b3" blue
        set -gx fish_color_quote "a3be8c" green
        set -gx fish_color_redirection "ebcb8b" yellow
        set -gx fish_color_end "96b5b4" cyan
        set -gx fish_color_error "bf616a" red
        set -gx fish_color_param "dfe1e8" cyan
        set -gx fish_color_comment "65737e" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "c0c5ce" white --bold --background=brblack
        set -gx fish_color_search_match "ebcb8b" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "96b5b4" cyan
        set -gx fish_color_escape "96b5b4" cyan
        set -gx fish_color_cwd "a3be8c" green
        set -gx fish_color_cwd_root "bf616a" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "65737e" brblack
        set -gx fish_color_user "a3be8c" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ebcb8b" yellow
        set -gx fish_pager_color_prefix "c0c5ce" white --bold --underline
        set -gx fish_pager_color_progress "eff1f5" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "2b" "30" "3b"
    __base16_fish_shell_create_vimrc_background ocean
    set -U base16_fish_theme ocean

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
