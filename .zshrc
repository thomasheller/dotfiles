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
alias l=ls
alias t=tail
alias v=vim
alias p='print -l'
alias src="source ~/.zshrc"
alias wl='wc -l'
function mcd() { mkdir $1 && cd $1 }
setopt autocd

