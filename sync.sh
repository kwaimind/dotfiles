#!/bin/bash

# Dotfiles sync script - backs up configs to this repo

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Syncing dotfiles to $DOTFILES_DIR..."

# Create directories
mkdir -p "$DOTFILES_DIR"/{zsh,git,vscode,homebrew,.claude}

# Zsh configs
echo "→ Copying zsh configs..."
cp ~/.zshrc "$DOTFILES_DIR/zsh/.zshrc"

# Git config
echo "→ Copying git config (excluding maintenance section)..."
awk '/^\[maintenance\]/ {skip=1; next} /^\[/ {skip=0} !skip' ~/.gitconfig > "$DOTFILES_DIR/git/.gitconfig"

# VSCode configs
echo "→ Copying VSCode configs..."
cp ~/Library/Application\ Support/Code/User/settings.json "$DOTFILES_DIR/vscode/settings.json"
cp ~/Library/Application\ Support/Code/User/keybindings.json "$DOTFILES_DIR/vscode/keybindings.json"

# Homebrew
echo "→ Generating Brewfile..."
cd "$DOTFILES_DIR/homebrew"
brew bundle dump --force
brew leaves > leaves.txt
cd "$DOTFILES_DIR"

# Claude configs
echo "→ Copying Claude configs..."
cp ~/.claude/CLAUDE.md "$DOTFILES_DIR/.claude/"
cp ~/.claude/settings.json "$DOTFILES_DIR/.claude/"
cp -r ~/.claude/commands "$DOTFILES_DIR/.claude/"
cp -r ~/.claude/agents "$DOTFILES_DIR/.claude/"
mkdir -p "$DOTFILES_DIR/.claude/skills"
for skill in ~/.claude/skills/*/; do
  name=$(basename "$skill")
  [[ "$name" == peon-* ]] && continue
  cp -r "$skill" "$DOTFILES_DIR/.claude/skills/"
done

echo "✓ Sync complete!"
