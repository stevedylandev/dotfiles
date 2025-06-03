function fcd
    set selected_file (fd . -t d --exclude node_modules | gum filter --prompt=" " --match.foreground="2" --indicator.foreground="2")
    if test "$status" -eq 0
        cd "$selected_file"
    else
        echo ""
    end
end

