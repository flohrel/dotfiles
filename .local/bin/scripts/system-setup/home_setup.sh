#!/bin/sh

GIT_URL='https://github.com/GMorizur/dotfiles.git'

# oh-my-zsh
if [ "$ZSH" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "ZSH est introuvable"
	exit 1
fi

CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh plugins
while IFS='' read -r plugin_url || [ -n "${plugin_url}" ]; do
	plugin_name=${plugin_url##*/}
	plugin_name=${plugin_name%.git}
	git clone $plugin_url "$CUSTOM/plugins/$plugin_name"
done < ./plugins

# powerlevel10k theme
git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "$CUSTOM/themes/powerlevel10k"

# VIM nerdtree
git clone "https://github.com/preservim/nerdtree.git" "$HOME/.vim/pack/vendor/start/nerdtree" && \
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

cd $HOME
# Dotfiles
git clone --bare $GIT_URL "$HOME/.cfg"
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
mkdir .old_cfg && \
cfg checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .old_cfg/{}.bak
cfg checkout
cfg config --local status.showUntrackedFiles no

exec zsh
