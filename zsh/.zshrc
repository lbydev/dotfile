export ZSH_CONF="$HOME/.config/zsh"

#POWERLEVEL9K_MODE="nerdfont-complete"
#ZSH_THEME="powerlevel10k/powerlevel10k"

source "$ZSH_CONF/env.zsh"
source "$ZSH_CONF/config.zsh"
source "$ZSH_CONF/alias.zsh"
source "$ZSH_CONF/starship.zsh"
source "$ZSH_CONF/golang.zsh"
source "$ZSH_CONF/git-functions.zsh"

# install plugins
# source "$ZSH_CONF/zplug.zsh"
source "$ZSH_CONF/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
