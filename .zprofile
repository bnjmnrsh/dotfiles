# Homebrew, Volta, pnpm, and local wrappers are established in ~/.zshenv so
# they are available to every zsh mode.
# macOS path_helper runs from /etc/zprofile after ~/.zshenv, so reassert the
# manager ordering here without adding duplicate entries on login shells.
typeset -U path PATH

# /etc/zprofile path_helper has run before this file. Keep Volta first, then
# prefer the installed Homebrew prefix ahead of inherited command locations.
if [[ -d /opt/homebrew/bin || -d /opt/homebrew/sbin ]]; then
  path=("$VOLTA_HOME/bin" /opt/homebrew/bin /opt/homebrew/sbin $path "$PNPM_HOME")
else
  path=("$VOLTA_HOME/bin" /usr/local/bin /usr/local/sbin $path "$PNPM_HOME")
fi
