# .zshrc - configuration for Zsh (zsh.org)
# by Thomas Heller
# latest version:
# https://github.com/thomasheller/dotfiles/

export PROMPT='%(?.%F{006}.%F{001})%B(%b%f%?%(?.%F{006}.%F{001})%B)%b%n%F{006}%B@%b%f%m%F{006}%B:%b%f%~%F{006}%B%#%b%f '
export EDITOR=vim
export GOPATH=$HOME/gocode
export PATH=$PATH:/usr/lib/go/bin:$GOPATH/bin
export DOTFILES=$HOME/dotfiles
export USEFUL_APT_ACKAGES=(git zsh vim screen curl netcat-openbsd zip unzip bzip2)

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias .s="$EDITOR $DOTFILES/screenrc"
alias .v="$EDITOR $DOTFILES/vimrc"
alias .z="$EDITOR $DOTFILES/zshrc"
alias ai='sudo apt-get install'
alias ac='apt-cache search'
alias md=mkdir
alias rd=rmdir
alias c=cat
alias cp='cp -i'
alias disp=display
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
alias reds='redshift -t 6500:1000'
alias src="source ~/.zshrc"
alias wl='wc -l'
alias G=git
alias Ga='git add'
alias Gb='git branch'
alias Gc='git clone'
alias Gcim='git commit -m'
alias Gciv='git commit -v'
alias Gcl='git clean -d --interactive'
alias Gco='git checkout'
alias Gd='git diff'
alias Gf='git fetch'
alias Gg='git grep'
alias Gi='git init'
alias Gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --graph'
alias Glf='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
alias Gm='git merge'
alias Gpl='git pull'
alias Gpo='git push origin'
alias Gr='git reset'
alias Gresethardmaster='git fetch origin && git reset --hard origin/master && git clean -df'
alias Grm='git rm'
alias Gs='git status'
alias Gsh='git show'
alias Gt='git tag'

if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
fi

alias img2pdf="convert -compress jpeg -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"
alias img2pdf_gray="convert -compress jpeg -colorspace gray -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"
alias img2pdf_mono="convert -compress jpeg -monochrome -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"

alias outlook="java -jar ~/outlook/MSGViewer-1.9/MSGViewer.jar"
alias zettelkasten='java -jar /usr/local/bin/Zettelkasten.jar'

function mcd() { mkdir -p $1 && cd $1 }

function provision-gui() {
  sudo apt-get install chromium-browser gimp imagemagick virtualbox-guest-dkms texmaker meld redshift
}

function go64() {
  GOARCH=amd64 GOOS=linux go $@
}

bindkey '^[[19~' insert-glob-all-non-dirs
bindkey '^Z' fetch-last-command-args-or-delete-first-word
bindkey '^M' ls-or-accept-line
zle -N insert-glob-all-non-dirs
function insert-glob-all-non-dirs() {
  LBUFFER=$LBUFFER'**/*(^/) '
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
zle -N ls-or-accept-line
function ls-or-accept-line {
  if [ $#BUFFER -eq 0 ]
  then
    BUFFER=l
  fi
  zle accept-line
}

setopt autocd
setopt extendedglob

stty stop undef
stty start undef

# init:

if [[ ${SHELL:t} != zsh ]]
then
  if grep $(command -v zsh) /etc/shells >/dev/null
  then
    echo Setting zsh as default shell
    chsh -s $(command -v zsh)
  else
    print -P %F{001}zsh is missing in /etc/shells%f
  fi
fi

function checkdotfile {
  local dotfile=.$1
  local repofile=$1
  if [[ ! -a ~/$dotfile ]]
  then
    # echo ~/$dotfile does not exist, symlinking to $DOTFILES/$repofile
    ln -s $DOTFILES/$repofile ~/$dotfile
  else if [[ $(realpath ~/$dotfile) != $DOTFILES/$repofile ]]
  then
    print -P %F{001}~/$dotfile exists, but is not a symlink to ~/dotfiles/$repofile%f
  fi
  fi
}
checkdotfile zshrc
checkdotfile vimrc
checkdotfile screenrc

if command -v apt-get >/dev/null
then
  if ! dpkg -s $USEFUL_APT_ACKAGES >/dev/null
  then
    sudo apt-get install $USEFUL_APT_ACKAGES
  fi
fi

if [[ ! -a ~/.vim/autoload/plug.vim ]]
then
  if ! curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  then
    print -P %F{001}Failed to download vim-plug%f
  fi
fi

if [[ -a ~/.vim/autoload/plug.vim && ( ! -d ~/.vim/plugged/nerdcommenter || ! -d ~/.vim/plugged/vim-go ) ]]
then
  vim +PlugInstall +qall
fi

# check if ~/dotfiles is up-to-date with GitHub:
function syncdotfiles {
  git -C $DOTFILES fetch origin || return
  if ! git -C $DOTFILES diff origin/master --exit-code >/dev/null
  then
    echo Dotfiles in origin/master have changed:
    git -C $DOTFILES status
  fi
}

if [[ $TERM == screen ]]
then
  echo Type \`syncdotfiles\' to sync dotfiles
else
  syncdotfiles
fi

if [[ -a ~/.zshrc.local ]]
then
  source ~/.zshrc.local
fi
