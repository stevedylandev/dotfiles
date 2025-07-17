# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# completion using vim keys
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

bindkey -v

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls="eza --icons=always"
alias ll="ls -l"
alias la="ls -a"
alias lg="lazygit"
alias nf="neofetch"
alias fl="fastfetch -c ~/.config/fastfetch/presets/examples/8.jsonc"
alias ff="fastfetch -c ~/.config/fastfetch/presets/examples/20.jsonc"
alias cd="z"
alias ai="aichat"
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

alias gs="git status"
alias ga="git add ."
alias gc="git commit"
alias gd="git diff | delta"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'"
alias gig="cp ~/.config/git/ignore $(pwd)/.gitignore"

gac() { git add . && git commit --message "$*" }


# Exports
export BAT_THEME="ansi"
export GOROOT="/usr/local/go"
export GOPATH="$HOME/.local/share/go"
export GOMODCACHE="$HOME/.local/share/go-mod-cache"

# PATH Configuration - Readable format with comments
# Homebrew
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.local/share"

# Go language
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/share/go/bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Standard user binaries
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/bin"

# JavaScript/Node.js tools
export PATH="$PATH:$HOME/.bun/bin"
export PATH="$PATH:$HOME/.deno/bin"

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# Terminal/Shell tools
export PATH="$PATH:$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin"

# Blockchain/Web3 tools
export PATH="$PATH:$HOME/.foundry/bin"
export PATH="$PATH:$HOME/.local/share/pinata"
export PATH="$PATH:$HOME/.helios/bin"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".git"' 
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#c1c1c1,fg+:#ffffff,bg:#121113,bg+:#222222
  --color=hl:#5f8787,hl+:#fbcb97,info:#e78a53,marker:#fbcb97
  --color=prompt:#e78a53,spinner:#5f8787,pointer:#fbcb97,header:#aaaaaa
  --color=border:#333333,label:#888888,query:#ffffff
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# bun completions
[ -s "/Users/steve-simkins/.bun/_bun" ] && source "/Users/steve-simkins/.bun/_bun"

# fzf
source <(fzf --zsh)

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/Users/steve-simkins/.deno/env"