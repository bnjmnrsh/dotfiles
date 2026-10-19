# Login-only additions. Homebrew and Volta are established in ~/.zshenv so
# they are also available to interactive non-login shells.
# macOS path_helper runs from /etc/zprofile after ~/.zshenv, so reassert the
# manager ordering here without adding duplicate entries on login shells.
typeset -U path PATH
path=("$VOLTA_HOME/bin" $path "$PNPM_HOME" "$HOME/.local/bin")
