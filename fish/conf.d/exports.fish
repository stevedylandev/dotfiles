# Exports
set -x MANPAGER 'nvim +Man!'
set -x TINTED_SHELL_ENABLE_BASE16_VARS "1"
set -x MANWIDTH 999
set -x PATH "$HOME/.cargo/bin:$PATH"
set -x PATH "$HOME/.local/share/go/bin:$PATH"
set -x PATH "$HOME/.local/bin:$PATH"
set -x PATH "/Applications/Docker.app/Contents/Resources/bin:$PATH"
set -x GOPATH "$HOME/.local/share/go"
set -x PATH "/opt/homebrew/opt/llvm/bin:$PATH"
set -x PATH "/Users/stevedsimkins/.local/share/solana/install/active_release/bin:$PATH"
set -x BAT_THEME ansi
# pnpm
set -x PNPM_HOME "/Users/stevedsimkins/.local/share/pnpm"
set -x PATH "$PNPM_HOME:$PATH"
# pnpm end
set -x FZF_DEFAULT_OPTS "--height 60% --layout=reverse --inline-info --border"
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
set -x ETHERSCAN_API_KEY $(prs show etherscan/secret)
set -x OATMEAL_THEME_FILE "/Users/stevedsimkins/.config/oatmeal/black-metal.tmTheme"
set -x nvm_default_version "20"
set -x LIBRARY_PATH "$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
set -x PATH "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib:$PATH"
set -x PATH "/Users/stevedsimkins/.local/share/solana/install/active_release/bin:$PATH"
