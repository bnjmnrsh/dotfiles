# Dotfiles

## Bare git repo

To not interfere with any other git repos that may be the filesystem root, this dotfiles repo has been set up as 'bare' (.cfg) with `config` set as an alias to `git`.

### Setup:

```
# Set up repo bare to not conflict with any other .git that may be in $HOME
git init --bare $HOME/.cfg

# Custom alias to our dotfiles instance of git to avoid confusion
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Don't show untracked files, as this would be our entire system
config config --local status.showUntrackedFiles no

#  Add the path to .zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
```

### Refs:
- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
