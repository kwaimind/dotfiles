#!/bin/bash

# Dotfiles install script - restores configs from this repo

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Backup existing configs
BACKUP_DIR=~/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"
echo "→ Backing up existing configs to $BACKUP_DIR..."

# Function to safely symlink
link_file() {
  local src=$1
  local dest=$2

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
}

# Zsh configs
echo "→ Linking zsh configs..."
link_file "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
link_file "$DOTFILES_DIR/zsh/.zshenv" ~/.zshenv
link_file "$DOTFILES_DIR/zsh/.zprofile" ~/.zprofile

# Git config
echo "→ Linking git config..."
link_file "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

# VSCode configs
echo "→ Linking VSCode configs..."
mkdir -p ~/Library/Application\ Support/Code/User
link_file "$DOTFILES_DIR/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
link_file "$DOTFILES_DIR/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

# GitHub CLI config
if [ -d "$DOTFILES_DIR/gh" ]; then
  echo "→ Linking GitHub CLI config..."
  mkdir -p ~/.config
  link_file "$DOTFILES_DIR/gh" ~/.config/gh
fi

# Homebrew
if ! command -v brew &> /dev/null; then
  echo "→ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "→ Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/homebrew/Brewfile"

# VSCode extensions
if command -v code &> /dev/null; then
  echo "→ Installing VSCode extensions..."
  while read -r extension; do
    code --install-extension "$extension" --force
  done < "$DOTFILES_DIR/vscode/extensions.txt"
fi

echo "✓ Installation complete!"
echo "  Backups saved to: $BACKUP_DIR"
