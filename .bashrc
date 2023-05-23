# Alias git command to config to manage dot files while not interfering with any other git repos in space
# This is a duplicate rule to one in .oh-my-zsh/custom/aliases.zsh incase we change shells or environments.

alias config='/usr/bin/git --git-dir=/Users/anachronistic/.cfg/ --work-tree=/Users/anachronistic'
