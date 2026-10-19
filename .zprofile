# Homebrew, Volta, pnpm, and local wrappers are established in ~/.zshenv so
# they are available to every zsh mode.
# macOS path_helper runs from /etc/zprofile after ~/.zshenv, so reassert the
# manager ordering here without adding duplicate entries on login shells.
typeset -U path PATH
path=("$VOLTA_HOME/bin" $path "$PNPM_HOME")
