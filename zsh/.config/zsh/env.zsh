export PATH=$PATH:/usr/bin:/usr/local/bin # brew

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/openresty/nginx/sbin:$PATH"

typeset -U PATH # Remove duplicates in $PATH
