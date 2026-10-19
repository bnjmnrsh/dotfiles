# Shared shell path setup. Keep this file free of interactive work: zsh reads it
# for login, interactive non-login, and non-interactive invocations.
typeset -U path PATH

# Make Homebrew commands available before Oh My Zsh is initialized.
if [[ -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
elif [[ -d /usr/local/bin ]]; then
  path=(/usr/local/bin /usr/local/sbin $path)
fi

# Volta owns Node.js and package-manager selection. Keep standalone pnpm tools
# available only after Volta's shims, so repository pins continue to win.
export VOLTA_HOME="${VOLTA_HOME:-$HOME/.volta}"
path=("$VOLTA_HOME/bin" $path "$HOME/.local/bin")

export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}"
path=($path "$PNPM_HOME")
