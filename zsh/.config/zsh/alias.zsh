
# docker
alias d='docker'
alias dc='docker-compose'
alias dcup='docker-compose up'
alias da='docker attach'

# git
alias gd='git dif'
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'
alias gbl='git show-branch --list'
alias gst='git status'
alias rm='rm -i'
#alias chmod='chmod --preserve-root'
alias gfo='git fetch origin'


# proxy
# proxy
proxy () {
  export http_proxy="http://127.0.0.1:6152"
  export https_proxy="http://127.0.0.1:6152"
  export all_proxy="socks5://127.0.0.1:6153"
  echo "Proxy on"
}
# noproxy
noproxy () {
  unset http_proxy
  unset https_proxy
  unset all_proxy
  echo "Proxy off"
}



# others
alias now='date +%s'
alias sz="source $HOME/.zshrc"
alias j='z'
alias ll='ls -lG'
# alias rg='rg --column --line-number --hidden --sort path --no-heading --color=always --smart-case -- '

# macos only
alias refresh-dns='sudo killall -HUP mDNSResponder'
