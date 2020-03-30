#!/bin/sh
#
# arch.sh installs useful basic packages on Arch Linux
# systems.
# 
# To bootstrap:
#
# curl -o arch.sh https://raw.githubusercontent.com/thomasheller/dotfiles/master/arch.sh
# chmod +x arch.sh
# ./arch.sh
#
set -e

echo '~~~ Installing pacman packages... ~~~'

sudo pacman -S --needed \
	git \
	base-devel \
	xorg-xsetroot \
	feh \
	fzf

if ! command -v yay >/dev/null 2>&1 ; then
	echo '~~~ yay not found, installing... ~~~'
	cd /tmp
	git clone https://aur.archlinux.org/yay
	cd yay
	makepkg -si
fi

echo '~~~ Installing AUR packages... ~~~'

yay -S polybar
yay -S gimme

