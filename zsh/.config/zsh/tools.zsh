# ===================================================================
# check tools exist
# ===================================================================

if ! type fzf > /dev/null; then
	echo fzf not found! use 'install_fzf' to install.
fi


export GITHUB_LOCATION="$HOME/Tools/github.com"

# ===================================================================
# install tools exist
# ===================================================================
install_fzf () {
	setpx
	set -e
	set -o xtrace
	export FZF_REPO=$GITHUB_LOCATION/junegunn/fzf
	if [ ! -d "$FZF_REPO" ]; then
		git clone https://github.com/junegunn/fzf.git $FZF_REPO
	fi
	cd $FZF_REPO
	git pull origin master
	$FZF_REPO/install
	cd -
	fzf --version
}
