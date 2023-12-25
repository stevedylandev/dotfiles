# Exports
set -x MANPAGER 'nvim +Man!'
set -x BASE16_THEME_DEFAULT base16-black-metal-dark-funeral
set -x MANWIDTH 999
set -x PATH "$HOME/.cargo/bin:$PATH"
set -x PATH "$HOME/.local/share/go/bin:$PATH"
set -x GOPATH "$HOME/.local/share/go"
set -x PATH "/opt/homebrew/opt/llvm/bin:$PATH"
set -x BAT_THEME ansi
# pnpm
set -x PNPM_HOME "$HOME/.local/share/pnpm"
set -x PATH "$PNPM_HOME:$PATH"
# pnpm end
set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --inline-info --border"
set -x _ZO_DATA_DIR "$HOME/.local/share/zoxide"

# set -gx NVM_DIR (brew --prefix nvm)
# set -x PATH "/Users/stevedsimkins/solana"/bin:"$PATH"
# source $NVM_DIR/nvm.sh; and nvm use
# set -x PATH "/Users/stevedsimkins/.local/share/solana/install/active_release/bin:$PATH"
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH "$BUN_INSTALL/bin:$PATH"
set -x PATH "/opt/homebrew/opt/curl/bin:$PATH"
set -x IPFS_GATEWAY "https://newonboardingflow.mypinata.cloud"
# ~/.tmux/plugins
set -x PATH $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
set -x PATH $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
