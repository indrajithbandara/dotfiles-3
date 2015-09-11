# Include utils!
source "$SELF/lib/utils.sh"

# Allow aliases to be run with sudo
alias sudo='sudo '

# Navigation
alias ..='cd ..'
alias .s='cd Source'
alias -- --='cd -'

# Show Color on grep
alias grep='grep --color=auto'

# LS specific
alias ls="ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first"
alias la="ls -lA"
alias cl="clear && la"

# show all ips
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6?(addr:)? ?/, \"\"); print }' && echo `dig +short myip.opendns.com @resolver1.opendns.com`"

# Erase the screen and show the file listing.
alias c="clear"
alias a="alias -p"
alias isGIT="git status >/dev/null 2>/dev/null"

# Enable an HTTP request from CLI
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "http-${method,,}"="lwp-request -m '$method'"
done

# These are for mac only
if ! $(isLinux); then

	# Text editors
	alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
	alias atom="/Applications/Atom.app/Contents/Resources/app/atom.sh"

	# Native JS REPL
	jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc";
	[ -e "${jscbin}" ] && alias js="${jscbin}";
	unset jscbin;

	alias os-upgrade="sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm@latest -g; npm update -g"

	alias os-flush-cache="dscacheutil -flushcache && killall -HUP mDNSResponder"
	alias os-flush-launch="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
	alias os-flush-dstore="sudo find . -type f -name '*.DS_Store' -ls -delete"
	alias os-flush-trash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

	alias os-files-show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias os-files-hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	alias os-icons-show="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias os-icons-hide="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

	alias os-spotlight-on="sudo mdutil -a -i on"
	alias os-spotlight-off="sudo mdutil -a -i off"

	alias os-audio-mute="osascript -e 'set volume output muted true'"
	alias os-audio-max="osascript -e 'set volume 7'"

	alias os-lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
	alias os-reload="exec $SHELL -l"
fi
