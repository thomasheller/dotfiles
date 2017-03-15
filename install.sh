#!/bin/sh

# Note that using these dotfiles will install various other software
# on your machine and change several settings. Please read and
# understand the entire code before trying them.

# See README.md for more information.

# The following commands provide a convenient way of installing
# everything from scratch:

# 1. Make sure git and zsh are installed
sudo apt-get -y install git zsh

# 2. Clone the repository
git clone https://github.com/thomasheller/dotfiles

# 3. Start zsh (press `q` to leave zsh-newuser-install)
exec zsh

# 4. Load configuration
source dotfiles/zshall

