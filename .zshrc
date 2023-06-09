# Path to your oh-my-zsh installation.
export ZSH="/Users/anachronistic/.oh-my-zsh"

ZSH_THEME=cobalt2

# Uncomment the following line to display red dots whilst waiting for completion.
# Can cause issues with multiline prompts (before zsh 5.7.1)
COMPLETION_WAITING_DOTS="true"

plugins=(
	brew
	composer
	colored-man-pages
	extract
	git
	lighthouse
	man
	macos
	node
	npm
	nvm
	ssh-agent
	vscode
	wp-cli
	z
)

# ssh support
zstyle :omz:plugins:ssh-agent identities orionrush-Bitbucket bnjmnrsh-Github

source $ZSH/oh-my-zsh.sh

#Set homebrew env vars
eval "$(/usr/local/bin/brew shellenv)"

# Use Z for better for a smarter cd.
#. $HOMEBREW_PREFIX/etc/profile.d/z.sh

# xdebug
XDEBUG_CONFIG="idekey=VSCODE"
