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
alias l=ls
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

setopt autocd
setopt extendedglob


