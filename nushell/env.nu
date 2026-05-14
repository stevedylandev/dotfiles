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
$env.GOPATH = ($env.HOME | path join ".local" "share" "go")
$env.GOMODCACHE = ($env.HOME | path join ".local" "share" "go-mod-cache")
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude ".git"'
$env.FZF_DEFAULT_OPTS = [
  '--color=fg:8:bold,fg+:15,bg:-1,bg+:-1'
  '--color=hl:10:bold,hl+:10:bold'
  '--color=info:8,spinner:9,header:4'
  '--color=prompt:2,pointer:9,marker:1'
  '--color=border:7,label:15:bold,query:15'
  '--border="rounded"'
  '--border-label=""'
  '--preview-window="border-rounded"'
  '--prompt="> "'
  '--marker=" "'
  '--pointer="◆"'
  '--separator=""'
  '--scrollbar=""'
  '--gutter=" "'
  '--info=inline-right'
] | str join ' '
path add ~/.tmux/plugins/t-smart-tmux-session-manager/bin
path add ~/.deno/bin
path add ~/.foundry/bin
path add ~/.local/share/
path add ~/.local/share/solana/install/active_release/bin
path add ~/.aztec/bin
path add ~/.nargo/bin
path add ~/.helios/bin

$env.config.filesize.unit = "MB"
$env.BAT_THEME_DARK = "ansi"
$env.BAT_THEME = "ansi"

fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH + "/bin")

$env.PNPM_HOME = ($env.HOME | path join "Library" "pnpm")
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME )

$env.GPG_TTY = (tty)
# source ~/.config/nushell/darkmatter.nu
source ~/.config/nushell/git-completions.nu
source ~/.cargo/env.nu

$env.EDITOR = "nvim"

$env.BULLETS_FEEDS = "feeds.stevedylan.dev/feed.xml"

zoxide init nushell | save -f ~/.zoxide.nu
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

