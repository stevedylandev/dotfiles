# Nushell Environment Config File
#
# version = "0.99.1"

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
$env.STARSHIP_SHELL = "nu"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]


# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"

# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

path add /opt/homebrew/bin
path add /usr/local/go/bin
path add ~/.cargo/bin
path add ~/.local/share/go/bin
path add ~/.local/bin
path add /usr/local/bin
path add ~/.bun/bin
path add /Applications/Docker.app/Contents/Resources/bin
$env.GOROOT = "/usr/local/go"
$env.GOPATH = "/Users/stevedylandev/.local/share/go"
$env.GOMODCACHE = "/Users/stevedylandev/.local/share/go-mod-cache"
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude ".git"'
$env.FZF_DEFAULT_OPTS = [
  '--color=fg:#c1c1c1,fg+:#ffffff,bg:#121113,bg+:#222222'
  '--color=hl:#5f8787,hl+:#fbcb97,info:#e78a53,marker:#fbcb97'
  '--color=prompt:#e78a53,spinner:#5f8787,pointer:#fbcb97,header:#aaaaaa'
  '--color=border:#333333,label:#888888,query:#ffffff'
  '--border="rounded"'
  '--border-label=""'
  '--preview-window="border-rounded"'
  '--prompt="> "'
  '--marker=">"'
  '--pointer="◆"'
  '--separator="─"'
  '--scrollbar="│"'
] | str join ' '
path add ~/.tmux/plugins/t-smart-tmux-session-manager/bin
path add ~/.deno/bin
path add ~/.foundry/bin
path add ~/.local/share/pinata-go-cli
path add ~/.local/share/
path add ~/.local/share/solana/install/active_release/bin
path add /Users/stevedylandev/.local/share/pinata
path add ~/.sp1/bin
path add ~/.aztec/bin
path add ~/.nargo/bin
path add ~/.helios/bin
$env.ANDROID_HOME = "~/Library/Android/sdk"
path add ~/Library/Android/sdk/emulator
path add ~/Library/Android/sdk/platform-tools
$env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
# $env.RUSTUP_TOOLCHAIN = "nightly-2025-01-05"
$env.config.filesize.unit = "MB"
$env.BAT_THEME_DARK = "ansi"
$env.BAT_THEME = "ansi"
# $env.FNM_DIR = "/Users/stevedsimkins/Library/Application Support/fnm"
# $env.FNM_ARCH = "arm64"
# $env.FNM_LOGLEVEL = "info"
# $env.FNM_COREPACK_ENABLED = "false"
# $env.FNM_RESOLVE_ENGINES = "false"
# $env.FNM_VERSION_FILE_STRATEGY = "local"
# $env.FNM_MULTISHELL_PATH = "/Users/stevedsimkins/.local/state/fnm_multishells/96094_1730946598404"
# $env.FNM_NODE_DIST_MIRROR = "https://nodejs.org/dist"
fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH + "/bin")

# To load from a custom file you can use:
# source ~/.config/nushell/env.nu

# source ~/.config/nushell/darkmatter.nu
source ~/.config/nushell/poimandres.nu
# source ~/.config/nushell/zoxide.nu
source ~/.config/nushell/git-completions.nu
source ~/.cargo/env.nu

$env.EDITOR = "nvim"

zoxide init nushell | save -f ~/.zoxide.nu
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
