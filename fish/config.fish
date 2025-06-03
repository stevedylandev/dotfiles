eval "$(/opt/homebrew/bin/brew shellenv)"
set -U fish_greeting
set -U fish_key_bindings fish_vi_key_bindings
set -U fish_cursor_default
set -Ux EDITOR nvim
set -Ux fish_color_autosuggestion normal
zoxide init fish | source
starship init fish | source
# source "/Users/stevedsimkins/.starkli/env"

export PATH="$PATH:/Users/stevedsimkins/.foundry/bin"

# Added by Radicle.
export PATH="$PATH:/Users/stevedsimkins/.radicle/bin"

function oatsesh
    set selected_session (oatmeal sessions list | awk '{print substr($0, index($0, "latest, ") + 8)}' | fzf)
    
    if test -n "$selected_session"
        set full_line (oatmeal sessions list | grep "$selected_session")
        set id_value (echo $full_line | grep -o '[a-f0-9]\{8\}-[a-f0-9]\{4\}' | head -n 1)
        
        if test -n "$id_value"
            oatmeal sessions open -i $id_value
        end
    end
end


fzf --fish | source
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata-go-cli:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata-go-cli:$PATH"
export PATH="/Users/stevedsimkins/.local/share/cast:$PATH"
export PATH="/Users/stevedsimkins/.local/share/cast:$PATH"
export PATH="/Users/stevedsimkins/.local/share/mast:$PATH"
export PATH="/Users/stevedsimkins/.local/share/mast:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"
export PATH="/Users/stevedsimkins/.local/share/pinata:$PATH"

export PATH="$PATH:/Users/stevedsimkins/.sp1/bin"
