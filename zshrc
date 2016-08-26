# .zshrc - configuration for Zsh (zsh.org)
# by Thomas Heller
# latest version:
# https://github.com/thomasheller/dotfiles/

export PROMPT='%n@%m:%~%# '
export EDITOR=vim

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias .s="$EDITOR ~/.screenrc"
alias .v="$EDITOR ~/.vimrc"
alias .z="$EDITOR ~/.zshrc"
alias md=mkdir
alias rd=rmdir
alias c=cat
alias h=head
alias g=grep
alias gi='grep -i'
alias gl='grep -l'
alias gw='grep -w'
alias l=ls
alias ll='ls -l'
alias t=tail
alias v=vim
alias p='print -l'
alias src="source ~/.zshrc"
alias wl='wc -l'

if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
fi

alias img2pdf="convert -compress jpeg -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"

alias outlook="java -jar ~/outlook/MSGViewer-1.9/MSGViewer.jar"
alias zettelkasten='java -jar /usr/local/bin/Zettelkasten.jar'

function mcd() { mkdir $1 && cd $1 }

# get latest dotfiles (local changes will be overwritten)
function dotfiles() {
  wget -O ~/.zshrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/.zshrc
  wget -O ~/.vimrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/.vimrc
  wget -O ~/.screenrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/.screenrc
}

function provision() {
  sudo apt-get install git vim screen
}

function provision-gui() {
  sudo apt-get install chromium-browser gimp
}

setopt autocd
setopt extendedglob


