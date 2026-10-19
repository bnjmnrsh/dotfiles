# Dependency recovery

This is a small recovery baseline, not a mirror of every application and package on the previous machine. It installs neither casks nor services, declares no direct runtime or version override, and does not run Homebrew cleanup. `--no-upgrade` does not pin formula versions.

## Before the first checkout

The dotfiles pre-commit hook needs `gitleaks`. On a new machine, install it after Homebrew is available and before checking out the bare repository:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew install gitleaks
```

Then clone and check out the repository as described in the README. After checkout, restore the core command-line tools:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew bundle --no-upgrade \
  --file="$HOME/.config/dotfiles/Brewfile"
```

Verify the declared baseline without updating or upgrading anything:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew bundle check --no-upgrade \
  --file="$HOME/.config/dotfiles/Brewfile"
```

`/bin/zsh` is the system shell used here; this recovery does not install Homebrew's `zsh`.

## Applications and shell framework

Homebrew, Oh My Zsh, Volta, Laravel Herd, Visual Studio Code, Warp, and Windsurf are machine prerequisites when their existing configuration is useful. Their installation, activation, upgrades, and configuration are outside this recovery. The Cobalt2 theme is tracked as a custom theme. Oh My Zsh's recorded framework revision (`964ddf789b022b6958b27d02d7fa54f552de21e9`) is informational, not a required pin; use bundled plugins only.

The tracked Git configuration has an LFS filter, but `git-lfs` is not installed on this machine. Install it only if a repository that needs LFS is being restored.

## Optional Homebrew leaves

This is an inventory snapshot, not a default install list: `actionlint`, `cloudflared`, `dnsmasq`, `fclones`, `git-filter-repo`, `micro`, `mysql`, `nginx`, `php@8.3`, `pipx`, `poppler`, `python@3.12`, and `tesseract`. Choose packages for the work at hand.

## Fonts

Existing editor configuration names Fira Code and Inconsolata for Powerline. Install only the fonts needed by the restored terminal/editor setup:

- [Fira Code installation instructions](https://github.com/tonsky/FiraCode/wiki/Installing)
- [Powerline fonts source](https://github.com/powerline/fonts)

Do not bulk-install the Powerline font collection.

## VS Code extensions

`vscode-extensions.txt` is a 136-entry `publisher.extension@version` inventory from this machine. It is a selection aid, not an extension restore command. Its versions are a snapshot; select extensions required for the current work and use a current compatible version when appropriate. Install them one at a time with the actual VS Code CLI:

```sh
"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
  --install-extension esbenp.prettier-vscode@12.4.0
```

The tracked `code` shell alias opens the application and does not forward command-line arguments. The local theme inventory entry is `undefined_publisher.bnjmnrsh-solarized-light@0.0.1`. Its configured source is [bnjmnrsh-solarized-light](https://github.com/bnjmnrsh/bnjmnrsh-solarized-light); current accessibility has not been checked. Its recovered source is privately backed up under `$HOME/.local/state/dotfiles/backups/2026-10-20-dependency-recovery/custom-vscode-theme`; use that source or an original VSIX to restore it.

## Legacy Node wrappers

`global-tools.json` identifies two isolated legacy wrappers. Their package manifests and lock files live under `legacy-tools/`. Copy the tracked directory to the named prefix, then use the specified Volta runtime and `npm ci`; do not regenerate their locks with `npm install --save-exact`.

```sh
wrangler_prefix="$HOME/.local/share/volta-legacy-tools/wrangler-2.1.6"
trash_prefix="$HOME/.local/share/volta-legacy-tools/trash-cli-6.0.0"
mkdir -p "$wrangler_prefix" "$trash_prefix"
cp "$HOME/.config/dotfiles/legacy-tools/wrangler-2.1.6/package.json" "$wrangler_prefix/"
cp "$HOME/.config/dotfiles/legacy-tools/wrangler-2.1.6/package-lock.json" "$wrangler_prefix/"
cp "$HOME/.config/dotfiles/legacy-tools/trash-cli-6.0.0/package.json" "$trash_prefix/"
cp "$HOME/.config/dotfiles/legacy-tools/trash-cli-6.0.0/package-lock.json" "$trash_prefix/"
volta run --node 18.16.0 --bundled-npm npm ci --prefix "$wrangler_prefix"
volta run --node 22.11.0 --bundled-npm npm ci --prefix "$trash_prefix"
wrangler2-legacy --version
trash-node --version
```
