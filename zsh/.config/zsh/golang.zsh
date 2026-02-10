# Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add Go binary path if exists
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
