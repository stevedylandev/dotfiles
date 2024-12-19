function oatshesh
    set selected_session (oatmeal sessions list | fzf)
    
    if test -n "$selected_session"
        set id_value (echo $selected_session | grep -o '[a-f0-9]\{8\}-[a-f0-9]\{4\}' | head -n 1)
        
        if test -n "$id_value"
            oatmeal sessions open -i $id_value
        end
    end
end
