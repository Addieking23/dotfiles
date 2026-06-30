#!/bin/bash
set -e

# Install yay if not installed
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm git base-devel
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)
  rm -rf "$tmpdir"
fi

# Install packages from Arch repos
mapfile -t packages < "$HOME/.local/share/chezmoi/arch_pkgs.txt"
if [ ${#packages[@]} -gt 0 ]; then
  sudo pacman -S --needed --noconfirm "${packages[@]}"
fi

# Install AUR packages
mapfile -t aur_packages < "$HOME/.local/share/chezmoi/arch_forign_pkgs.txt"
if [ ${#aur_packages[@]} -gt 0 ]; then
  yay -S --needed --noconfirm "${aur_packages[@]}"
fi
