function inv
    set selected_file (fzf -m --preview='bat --color=always {}')
    if test "$status" -eq 0
        nvim "$selected_file"
    else
        echo "Selection canceled."
    end
end
