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
	man-db man-pages texinfo \
	vim \
	zsh \
	zsh-syntax-highlighting \
	xorg-server xorg-xinit \
	noto-fonts noto-fonts-emoji \
	alacritty \
	git \
	base-devel \
	xorg-xsetroot \
	xdotool \
#	feh \
#	fzf \
#	entr \
#	unclutter \
	alsa-utils \
	wireless_tools \
	chromium

if ! command -v yay >/dev/null 2>&1 ; then
	echo '~~~ yay not found, installing... ~~~'
	cd /tmp
	git clone https://aur.archlinux.org/yay
	cd yay
	makepkg -si
fi

echo '~~~ Installing AUR packages... ~~~'

# yay -S polybar
# yay -S gimme
yay -S libxft-bgra

