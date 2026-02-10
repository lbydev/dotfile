# Git utility functions

# cd to root dir of git project
droot() {
  cd $(git rev-parse --show-toplevel)
}

# cd to root of .git project (alias)
g.() {
  export git_dir="$(git rev-parse --show-toplevel 2> /dev/null)"
  if [ -z $git_dir ]
  then
    cd ..
  else
    cd $git_dir
  fi
}

# Create new branch
geb() {
  git checkout -b "$1"
}

# Pull from current branch
gpo() {
  git pull origin $(git symbolic-ref --short -q HEAD)
}

# Ignore files and remove them if they were tracked
gri() {
  git rm "$*"
  git rm --cached "$*"
}

# See contents of git project as a tree (excluding .git)
gte() {
  tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Functions requiring fzf (only if fzf is installed)
if command -v fzf &> /dev/null; then
  # Search local branches -> checkout to branch & delete previous branch
  gbb() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    git branch -D @{-1}
  }

  # Search local branches -> delete local branch
  gbd() {
    if [ $# -eq 0 ]; then
      local branches branch
      branches=$(git branch -vv) &&
      branch=$(echo "$branches" | fzf +m) &&
      git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    else
      git branch -D "$@"
    fi
  }

  # Git checkout branch (searches local branches)
  ge() {
    if [ $# -eq 0 ]; then
      local branches branch
      branches=$(git branch -vv) &&
      branch=$(echo "$branches" | fzf +m) &&
      git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    else
      git checkout "$@"
    fi
  }

  # Git commit browser (searches commits)
  gC() {
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"  | \
     fzf --ansi --no-sort --reverse --tiebreak=index --preview \
     'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
     --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
FZF-EOF" --preview-window=right:60%
  }
fi
