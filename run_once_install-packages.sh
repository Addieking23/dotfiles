#!/bin/bash
set -e

# Install yay if not installed
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  makepkg -si --noconfirm
fi

# Install packages from Arch repos
packages=$(cat "$HOME/.local/share/chezmoi/arch_pkgs.txt")
sudo pacman -S --needed "$packages"

# Install AUR packages
aur_packages="$HOME/.local/share/chezmoi/arch_forign_pkgs.txt"
yay -S --needed "$aur_packages"
