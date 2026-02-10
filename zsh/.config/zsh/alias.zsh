# docker
alias d='docker'
alias dc='docker-compose'
alias dcup='docker-compose up'
alias da='docker attach'

# git
alias gd='git diff'
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'
alias gbl='git show-branch --list'
alias gst='git status'
alias gfo='git fetch origin'

# common
alias rm='rm -i'
alias l='ls -alh'
alias lm='ls -alh | "$PAGER"'
alias ll='ls -lG'
alias now='date +%s'
alias j='z'

# bat (better cat)
if command -v bat &> /dev/null; then
    alias cat='bat --theme OneHalfDark --style=plain --paging=never'
fi

# lazygit
alias lg="lazygit"

# macOS specific
if [[ "$(uname)" == "Darwin" ]]; then
    alias refresh-dns='sudo killall -HUP mDNSResponder'
    alias wechat='nohup /Applications/WeChat.app/Contents/MacOS/WeChat > /dev/null 2>&1 &'
fi
