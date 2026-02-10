# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# ==========================================
# User Configuration
# ==========================================

export ZSH_CONF="$HOME/.config/zsh"

# Source configuration modules
source "$ZSH_CONF/env.zsh"
source "$ZSH_CONF/config.zsh"
source "$ZSH_CONF/alias.zsh"
source "$ZSH_CONF/starship.zsh"
source "$ZSH_CONF/golang.zsh"
source "$ZSH_CONF/git-functions.zsh"

# ==========================================
# Completion Configuration (AFTER Zim init)
# ==========================================
#
# IMPORTANT: zstyle ':completion:*' commands can trigger completion initialization
# We must ensure compinit is already called before setting these styles

# Tab completion ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' rehash true

# ==========================================
# User Functions
# ==========================================

# pretty diff (need to install diff-so-fancy)
# brew install diff-so-fancy OR npm i -g diff-so-fancy
function dff(){
    diff -u $@ | diff-so-fancy | less --tabs=4 -RFX
}

# fix systemd
# https://github.com/ohmyzsh/ohmyzsh/issues/8751
function _systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# ==========================================
# History Configuration
# ==========================================

# for history-substring-search module
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# ==========================================
# Environment Variables
# ==========================================

# Common Env
export EDITOR='vim'
export VISUAL='vim'

# Use default grep colors
export GREP_COLOR='01;31'
export GREP_COLORS='mt=01;31'

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ==========================================
# Path Configuration (Consolidated)
# ==========================================

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# User local bin
export PATH="$HOME/.local/bin:$PATH"

# MySQL (current version)
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# PostgreSQL (if exists)
if [ -d /usr/local/opt/libpq/bin ]; then
    export PATH="/usr/local/opt/libpq/bin:$PATH"
fi

# Pyenv (if installed)
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
alias cmt='opencode -m opencode/minimax-m2.1-free run "commit"'

# ==========================================
# System-specific Configuration
# ==========================================

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
    source "$ZSH_CONF/config.macos.zsh"
fi

# ==========================================
# External Tools (Load at the end)
# ==========================================

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER='ll'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-autosuggestions
# NOTE: Disabled because Zim Framework already manages zsh-autosuggestions
# See ~/.zimrc for the module configuration
# if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
#     source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# fi

# z.lua
if [ -f "$ZSH_CONF/z.lua" ]; then
    eval "$(luajit $ZSH_CONF/z.lua --init zsh enhanced once echo)"
fi

# tools check
source "$ZSH_CONF/tools.zsh"

# ==========================================
# Plugin Configuration
# ==========================================

# zsh-autosuggestions: enable abbreviations strategy
ZSH_AUTOSUGGEST_STRATEGY=(abbreviations history completion)

# zsh-proxy: configure proxy addresses
export PROXY_HTTP="http://127.0.0.1:6152"
export PROXY_SOCKS5="socks5://127.0.0.1:6153"

# ==========================================
# iTerm2 Integration
# ==========================================

# Set the iTerm tab title to the current directory, not full path.
DISABLE_AUTO_TITLE="true"
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

# ==========================================
# Local Configuration (Machine-specific)
# ==========================================
# Load local configuration file if it exists
# This file should contain machine-specific settings like:
# - API keys and tokens
# - Local paths
# - Private aliases
# NOTE: .zshrc.local is NOT tracked by git
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
