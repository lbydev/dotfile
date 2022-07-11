export ZSH_CONF="$HOME/.config/zsh"

#POWERLEVEL9K_MODE="nerdfont-complete"
#ZSH_THEME="powerlevel10k/powerlevel10k"

source "$ZSH_CONF/env.zsh"
source "$ZSH_CONF/config.zsh"
source "$ZSH_CONF/alias.zsh"
source "$ZSH_CONF/starship.zsh"
source "$ZSH_CONF/golang.zsh"
source "$ZSH_CONF/git-functions.zsh"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# pretty diff(need to install diff-so-fancy)
# brew install diff-so-fancy ORRRR npm i -g diff-so-fancy
function dff(){
    diff -u $@ | diff-so-fancy | less --tabs=4 -RFX
}

# fix systemd
# https://github.com/ohmyzsh/ohmyzsh/issues/8751
function _systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# for history-substring-search module, this configuration may no longer be needed in the future
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# Common Env
export EDITOR='vim'
export VISUAL='vim'

# Use default grep colors
export GREP_COLOR='01;31'
export GREP_COLORS='mt=01;31'

#Export Path
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/openresty/nginx/sbin:$PATH"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# system specified configuration
if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
	source "$ZSH_CONF/config.macos.zsh"
fi


#------------------------------------------------------------------------
# these external tools need to be imported in the end
#------------------------------------------------------------------------

# # fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER='ll'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# check tools in the end
source "$ZSH_CONF/tools.zsh"
eval "$(luajit $ZSH_CONF/z.lua --init zsh)"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set the iTerm tab title to the current directory, not full path.
DISABLE_AUTO_TITLE="true"
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}