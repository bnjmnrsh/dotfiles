# Aliases & Shortcuts

# Start new sessions in WebDev
cd ~/Documents/WebDev

WebDev=~/Documents/WebDev

# Set up alias for config to manage dot files with git
alias config='/usr/bin/git --git-dir=/Users/anachronistic/.cfg/ --work-tree=/Users/anachronistic'

# Applications
alias code="open -a '/Applications/Visual Studio Code.app'"
alias md="open -a 'Macdown'"

#CLI
# screenfetch for terminal screenshots
alias screenfetch='screenfetch -E'

# Composer
alias composer="php /usr/local/bin/composer.phar"

# Util
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias restart="source ~/.zshrc && clear"

# Load project specifc aliases (.gitignored)
[ -r .project-aliases ] && source .project-aliases
