# Dotfiles

## Bare git repo

To avoid interfering with Git repositories elsewhere in the filesystem, these dotfiles use a bare repository at `~/.cfg`, with the home directory as its work tree. Use the `config` function as a substitute for `git` when managing this repository.

```sh
unalias config 2>/dev/null || true
function config { /usr/bin/git --git-dir="$HOME/.cfg" --work-tree="$HOME" "$@"; }
```

The shell function must be defined by your shell configuration so it works from any directory. Normal `git` commands continue to operate on the repository in the current directory.

## First setup or recovery

Install dependencies before checkout. The expected macOS setup includes Homebrew, Zsh, Oh My Zsh, Volta, Laravel Herd, direnv, Composer, the fonts used by your terminal and editor, and the editor extensions you rely on. Existing editor settings name FiraCode and Inconsolata for Powerline; install fonts only from a trusted source if the restored machine does not have them. Package-manager pins in their own repositories remain independent of this dotfiles repository.

Once Homebrew is installed, install the command-line dependencies without updating every formula:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew install zsh composer direnv gh gitleaks
```

Install Oh My Zsh before checkout so its framework files exist first. Any collisions reported by checkout use the backup procedure below; do not force either installation.

```sh
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Volta is the preferred manager for Node and pnpm. After Volta itself is installed and available, restore the current tool defaults:

```sh
volta install node@24.11.0 npm@11.16.0 pnpm@11.7.0
```

After cloning the bare repository, restore files without overwriting anything already present:

```sh
git clone --bare git@github.com:bnjmnrsh/dotfiles.git "$HOME/.cfg"
unalias config 2>/dev/null || true
function config { /usr/bin/git --git-dir="$HOME/.cfg" --work-tree="$HOME" "$@"; }
config config --local status.showUntrackedFiles no
config checkout
```

If checkout reports collisions, keep the existing files safe and compare them before choosing what to restore:

```sh
backup_dir="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -m 700 "$backup_dir"
# Move only the paths named by `config checkout`; then run `config checkout` again.
```

Do not use a forced checkout. Once the checkout succeeds, run the tracked bootstrap script:

```sh
"$HOME/.config/dotfiles/setup.sh"
```

It installs the tracked private exclusion list into `~/.cfg/info/exclude` while retaining unrelated local patterns, and it configures hooks only for this bare repository. It does not change global Git configuration or hooks in other repositories.

`~/.zshrc.local` is an optional, untracked file for machine-specific shell settings and secrets. Create it only after the managed shell configuration is restored, and use owner-only permissions if it contains secrets:

```sh
install -m 600 /dev/null "$HOME/.zshrc.local"
```

## Safe changes

Add each intended dotfile explicitly; never use `git add .` in this repository.

```sh
config add "$HOME/.zshrc" "$HOME/.gitconfig"
config status
config commit -m "Update shell and Git settings"
```

The pre-commit hook requires gitleaks and scans staged content with redacted output. It also rejects staged private paths, including files force-added with Git. Install gitleaks with Homebrew when it is absent:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew install gitleaks
```

Before relying on the repository, inspect both its reachable history and current staged changes without exposing detected values:

```sh
gitleaks git --log-opts='--all' --redact --no-banner \
  --gitleaks-ignore-path "$HOME/.config/dotfiles/gitleaksignore" "$HOME/.cfg"
GIT_DIR="$HOME/.cfg" GIT_WORK_TREE="$HOME" \
  gitleaks protect --staged --redact --no-banner --source "$HOME" \
  --gitleaks-ignore-path "$HOME/.config/dotfiles/gitleaksignore"
```

## References

- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
