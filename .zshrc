# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
	vscode
	wp-cli
	z
)


source "$ZSH/oh-my-zsh.sh"

# Oh My Zsh plugins may amend PATH. Reassert the shared manager ordering once
# after they load and discard duplicate entries from repeated shell reloads.
typeset -U path PATH
path=("$VOLTA_HOME/bin" $path "$PNPM_HOME")

# Use Z for better for a smarter cd.
#. $HOMEBREW_PREFIX/etc/profile.d/z.sh

# xdebug
XDEBUG_CONFIG="idekey=VSCODE"



# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
path=("$HOME/Library/Application Support/Herd/bin" $path)

# Added by Windsurf
path=("$HOME/.codeium/windsurf/bin" $path)



# Task Master aliases added on 8/7/2025
alias tm='task-master'
alias taskmaster='task-master'

if [[ "$TERM_PROGRAM" == "kiro" ]] && (( $+commands[kiro] )); then
  source "$(kiro --locate-shell-integration-path zsh)"
fi


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"


# direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# Keep Volta ahead of any Node installation a preserved integration adds.
typeset -U path PATH
path=("$VOLTA_HOME/bin" $path "$PNPM_HOME")

# Machine-local customizations stay outside the tracked configuration.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
