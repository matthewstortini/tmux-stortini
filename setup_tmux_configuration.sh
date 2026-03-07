#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_CONF_SOURCE="$REPO_DIR/tmux.conf"
TMUX_CONF_TARGET="$HOME/.tmux.conf"

REPO_PLUGIN_DIR="$REPO_DIR/plugins"
HOME_PLUGIN_DIR="$HOME/.tmux/plugins"

if [[ ! -f "$TMUX_CONF_SOURCE" ]]; then
  echo "Error: tmux.conf not found in repo."
  exit 1
fi

# handle existing ~/.tmux.conf
if [[ -e "$TMUX_CONF_TARGET" || -L "$TMUX_CONF_TARGET" ]]; then
  echo "~/.tmux.conf already exists."
  read -r -p "Overwrite it with repo version? (y/n): " answer
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Aborting."
    exit 0
  fi
  rm -rf "$TMUX_CONF_TARGET"
fi

echo "Linking tmux configuration..."
ln -s "$TMUX_CONF_SOURCE" "$TMUX_CONF_TARGET"

mkdir -p "$REPO_PLUGIN_DIR"
mkdir -p "$HOME_PLUGIN_DIR"

echo "Installing/updating plugins..."

grep -E "set -g @plugin" "$TMUX_CONF_SOURCE" \
  | sed -E "s/.*'([^']+)'.*/\1/" \
  | while read -r plugin; do
      repo_name="${plugin##*/}"
      repo_clone_dir="$REPO_PLUGIN_DIR/$repo_name"
      home_link_dir="$HOME_PLUGIN_DIR/$repo_name"
      repo_url="https://github.com/$plugin.git"

      if [[ -d "$repo_clone_dir/.git" ]]; then
        echo "Updating $plugin"
        git -C "$repo_clone_dir" pull --ff-only
      else
        echo "Cloning $plugin"
        git clone "$repo_url" "$repo_clone_dir"
      fi

      if [[ -e "$home_link_dir" || -L "$home_link_dir" ]]; then
        rm -rf "$home_link_dir"
      fi

      ln -s "$repo_clone_dir" "$home_link_dir"
      echo "Linked ~/.tmux/plugins/$repo_name -> $repo_clone_dir"
    done

    echo "Done."
    echo
    echo "~/.tmux.conf now links to:"
    echo "  $TMUX_CONF_SOURCE"
    echo
    echo "~/.tmux/plugins now contains symlinks to:"
    echo "  $REPO_PLUGIN_DIR"
    echo
    echo "To activate the config:"
    echo "  tmux source-file ~/.tmux.conf"
