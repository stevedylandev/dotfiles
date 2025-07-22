# Retrieve the theme settings
export def main [] {
    return {
        binary: '#89DDFF'
        block: '#506477'
        cell-path: '#E4F0FB'
        closure: '#ADD7FF'
        custom: '#E4F0FB'
        duration: '#FFFAC2'
        float: '#5DE4C7'
        glob: '#E4F0FB'
        int: '#89DDFF'
        list: '#ADD7FF'
        nothing: '#5DE4C7'
        range: '#FFFAC2'
        record: '#ADD7FF'
        string: '#FCC5E9'

        bool: {|| if $in { '#ADD7FF' } else { '#FFFAC2' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#5DE4C7' attr: 'b' }
            } else if $in < 6hr {
                '#5DE4C7'
            } else if $in < 1day {
                '#FFFAC2'
            } else if $in < 3day {
                '#FCC5E9'
            } else if $in < 1wk {
                { fg: '#FCC5E9' attr: 'b' }
            } else if $in < 6wk {
                '#ADD7FF'
            } else if $in < 52wk {
                '#506477'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#E4F0FB'
            } else if $e < 1mb {
                '#ADD7FF'
            } else {{ fg: '#506477' }}
        }

        shape_and: { fg: '#89DDFF' attr: 'b' }
        shape_binary: { fg: '#89DDFF' attr: 'b' }
        shape_block: { fg: '#506477' attr: 'b' }
        shape_bool: '#ADD7FF'
        shape_closure: { fg: '#ADD7FF' attr: 'b' }
        shape_custom: '#FCC5E9'
        shape_datetime: { fg: '#ADD7FF' attr: 'b' }
        shape_directory: '#ADD7FF'
        shape_external: '#ADD7FF'
        shape_external_resolved: '#ADD7FF'
        shape_externalarg: { fg: '#FCC5E9' attr: 'b' }
        shape_filepath: '#ADD7FF'
        shape_flag: { fg: '#506477' attr: 'b' }
        shape_float: { fg: '#5DE4C7' attr: 'b' }
        shape_garbage: { fg: '#FFFFFF' bg: '#D0679D' attr: 'b' }
        shape_glob_interpolation: { fg: '#ADD7FF' attr: 'b' }
        shape_globpattern: { fg: '#ADD7FF' attr: 'b' }
        shape_int: { fg: '#89DDFF' attr: 'b' }
        shape_internalcall: { fg: '#ADD7FF' attr: 'b' }
        shape_keyword: { fg: '#89DDFF' attr: 'b' }
        shape_list: { fg: '#ADD7FF' attr: 'b' }
        shape_literal: '#506477'
        shape_match_pattern: '#FCC5E9'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#5DE4C7'
        shape_operator: '#FFFAC2'
        shape_or: { fg: '#89DDFF' attr: 'b' }
        shape_pipe: { fg: '#89DDFF' attr: 'b' }
        shape_range: { fg: '#FFFAC2' attr: 'b' }
        shape_raw_string: { fg: '#E4F0FB' attr: 'b' }
        shape_record: { fg: '#ADD7FF' attr: 'b' }
        shape_redirection: { fg: '#89DDFF' attr: 'b' }
        shape_signature: { fg: '#FCC5E9' attr: 'b' }
        shape_string: '#FCC5E9'
        shape_string_interpolation: { fg: '#ADD7FF' attr: 'b' }
        shape_table: { fg: '#506477' attr: 'b' }
        shape_vardecl: { fg: '#506477' attr: 'u' }
        shape_variable: '#89DDFF'

        foreground: '#E4F0FB'
        background: '#1B1E28'
        cursor: '#A6ACCD'

        empty: '#506477'
        header: { fg: '#FCC5E9' attr: 'b' }
        hints: '#171922'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#FCC5E9' attr: 'b' }
        search_result: { fg: '#5DE4C7' bg: '#E4F0FB' }
        separator: '#E4F0FB'
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate