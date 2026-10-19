# Aliases & Shortcuts

# Web development workspace shortcut. Shell startup does not change directories.
WebDev="$HOME/Documents/WebDev"

# Set up alias for config to manage dot files with git
unalias config 2>/dev/null
function config {
  git --git-dir="$HOME/.cfg" --work-tree="$HOME" "$@"
}

# Applications
alias code="open -a '/Applications/Visual Studio Code.app'"
alias md="open -a 'Macdown'"

# CLI
# screenfetch for terminal screenshots
alias screenfetch='screenfetch -E'

# Use better editor
#export EDITOR='micro'
#alias nano='micro'

# Util
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias restart='source "$HOME/.zshrc" && clear'

# Better Commits
alias bc="better-commits"

# Load project specifc aliases (.gitignored)
[[ -r "$HOME/.oh-my-zsh/custom/.project-aliases" ]] && source "$HOME/.oh-my-zsh/custom/.project-aliases"

