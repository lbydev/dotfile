# path
_enabled_paths=(
	"/usr/bin"
	"/usr/local/bin"
)

for _enabled_path in $_enabled_paths[@]; do
	# only add to $PATH when path exist and path not in $PATH
	[[ -d "${_enabled_path}" ]] && \
	[[ ! :$PATH: == *":${_enabled_path}:"* ]] && \
	PATH="$PATH:${_enabled_path}"
done

# tab completion ignore case
# https://superuser.com/questions/1092033/how-can-i-make-zsh-tab-completion-fix-capitalization-errors-for-directories-and
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History config
HISTSIZE=10000
SAVEHIST=10000

HISTFILE=$HOME/.zsh_history
setopt append_history
setopt share_history
setopt long_list_jobs
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_no_store
setopt interactivecomments
zstyle ':completion:*' rehash true
