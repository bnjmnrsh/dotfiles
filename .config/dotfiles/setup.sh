#!/bin/sh
set -eu

dotfiles_home=${HOME:?HOME must be set}
dotfiles_git="$dotfiles_home/.cfg"
dotfiles_config="$dotfiles_home/.config/dotfiles"
exclude_source="$dotfiles_config/git-exclude"
exclude_target="$dotfiles_git/info/exclude"
hooks_path="$dotfiles_config/hooks"

if [ ! -d "$dotfiles_git" ]; then
  printf '%s\n' "setup: expected bare repository at $dotfiles_git" >&2
  exit 1
fi

if [ ! -f "$exclude_source" ]; then
  printf '%s\n' "setup: expected tracked exclusions at $exclude_source" >&2
  exit 1
fi

if [ ! -d "$hooks_path" ]; then
  printf '%s\n' "setup: expected hooks directory at $hooks_path" >&2
  exit 1
fi

if ! command -v gitleaks >/dev/null 2>&1; then
  printf '%s\n' 'setup: gitleaks is required before installing the pre-commit hook.' >&2
  exit 1
fi

mkdir -p "$dotfiles_git/info"
exclude_tmp=$(mktemp "$dotfiles_git/info/exclude.XXXXXX")
trap 'rm -f "$exclude_tmp"' EXIT HUP INT TERM

# Replace only this managed block; preserve every unrelated local pattern.
if [ -f "$exclude_target" ]; then
  awk '
    $0 == "# BEGIN dotfiles private excludes" { skip = 1; next }
    $0 == "# END dotfiles private excludes" { skip = 0; next }
    !skip { print }
  ' "$exclude_target" > "$exclude_tmp"
fi

{
  printf '%s\n' '# BEGIN dotfiles private excludes'
  cat "$exclude_source"
  printf '%s\n' '# END dotfiles private excludes'
} >> "$exclude_tmp"
mv "$exclude_tmp" "$exclude_target"
trap - EXIT HUP INT TERM

/usr/bin/git --git-dir="$dotfiles_git" --work-tree="$dotfiles_home" \
  config --local core.hooksPath "$hooks_path"

printf '%s\n' 'setup: private exclusions and the dotfiles pre-commit hook are installed.'
