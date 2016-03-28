# Sources utils only if they are not already available
[[ ! $DOTFILES_UTILS ]] && source "${BASH_SOURCE%/*}/utils.sh"

isDarwin && source "$DOTFILES_LIB/install-osx.sh"
isArch   && source "$DOTFILES_LIB/install-arch.sh"

# Make sure vim's plugin manager is installed
[ ! -f ~/.vim/autoload/plug.vim ] && \
	echo "Installing vim's plugin manager" && \
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make sure tmux's plugin manager is installed
[ ! -d ~/.tmux/plugins/tpm ] && \
	echo "Installing tmux's plugin manager" && \
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 

if [ -z "$(nvm ls default)" ]; then
	echo "Enabling latest version of node"
	target=$(nvm ls-remote | tail -1 | xargs)
	nvm install $target
	nvm alias default $target
fi

# Install powerline fonts
if [ ! -d $DOTFILES_LNK/fonts ]; then
	echo "Installing powerline fonts"
	git clone https://github.com/powerline/fonts.git $DOTFILES_LNK/fonts
	$DOTFILES_LNK/fonts/install.sh
fi

# Enable italics on xterm and tmux
tic -x $DOTFILES_LIB/xterm-256color-italic.terminfo
tic -x $DOTFILES_LIB/tmux-256color.terminfo
