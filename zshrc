# .zshrc - configuration for Zsh (zsh.org)
# by Thomas Heller
# latest version:
# https://github.com/thomasheller/dotfiles/

export PROMPT='%n@%m:%~%# '
export EDITOR=vim
export GOPATH=$HOME/gocode
export PATH=$PATH:/usr/lib/go/bin:$GOPATH/bin

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias .s="$EDITOR ~/.screenrc"
alias .v="$EDITOR ~/.vimrc"
alias .z="$EDITOR ~/.zshrc"
alias ai='sudo apt-get install'
alias ac='apt-cache search'
alias md=mkdir
alias rd=rmdir
alias c=cat
alias cp='cp -i'
alias h=head
alias g=grep
alias gb='go build'
alias gg='go get'
alias gi='grep -i'
alias gl='grep -l'
alias gil='grep -il'
alias gw='grep -w'
alias l=ls
alias ll='ls -l'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias mv='mv -i'
alias rm='rm -i'
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

function mcd() { mkdir -p $1 && cd $1 }

# get latest dotfiles (local changes will be overwritten)
function dotfiles() {
  wget -O ~/.zshrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/zshrc
  wget -O ~/.vimrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/vimrc
  wget -O ~/.screenrc https://raw.githubusercontent.com/thomasheller/dotfiles/master/screenrc
}

function provision() {
  sudo apt-get install git vim screen
}

function provision-gui() {
  sudo apt-get install chromium-browser gimp
}

function go64() {
  GOARCH=amd64 GOOS=linux go $@
}

bindkey '^[[19~' insert-glob-all-non-dirs
bindkey '^Z' fetch-last-command-args-or-delete-first-word
zle -N insert-glob-all-non-dirs
function insert-glob-all-non-dirs() {
  LBUFFER=$LBUFFER' **/*(^/) '
}
zle -N fetch-last-command-args-or-delete-first-word
function fetch-last-command-args-or-delete-first-word {
  if [ $#BUFFER -eq 0 ]
    then
      LBUFFER=' '!*
      zle complete-word
      CURSOR=0
    else
      CURSOR=0
      zle delete-word
  fi
}


setopt autocd
setopt extendedglob


