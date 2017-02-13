# .zshrc - configuration for Zsh (zsh.org)
# by Thomas Heller
# latest version:
# https://github.com/thomasheller/dotfiles/

export GOPATH=$HOME/gocode

typeset -U path
path+=/usr/local/go/bin
path+=$GOPATH/bin
path+=$HOME/bin
path+=$HOME/.vim/bundle/vimpager

# install useful stuff:

if command -v apt-get >/dev/null
then
  local -a USEFUL_APT_PACKAGES
  USEFUL_APT_PACKAGES=(git zsh vim vim-pathogen screen curl netcat-openbsd zip unzip bzip2 golang pdfgrep tmux nmap tree)
  if ! dpkg -s $USEFUL_APT_PACKAGES >/dev/null
  then
    sudo apt-get install $USEFUL_APT_PACKAGES
  fi
fi

if command -v go >/dev/null
then
  if [[ ! -a $GOPATH/bin/jsonpp ]]
  then
    go get github.com/jmhodges/jsonpp
  fi
else 
  print -P %F{001}Golang is not available%f
fi

if [[ ! -a ~/.vim/autoload/plug.vim ]]
then
  if ! curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  then
    print -P %F{001}Failed to download vim-plug%f
  fi
fi

if [[ ! -a ~/.vim/bundle/vim-dirdiff ]]
then
  echo Installing vim-dirdiff...
  git clone https://github.com/will133/vim-dirdiff ~/.vim/bundle/vim-dirdiff || print -P %F{001}Failed to install vim-dirdiff%f
fi

if [[ ! -a ~/.vim/bundle/vimpager ]]
then
  echo Installing vimpager...
  git clone https://github.com/rkitover/vimpager ~/.vim/bundle/vimpager || print -P %F{001}Failed to install vimpager%f
fi

if [[ ! -a ~/.vim/bundle/vim-g ]]
then
  echo Installing vim-g...
  git clone https://github.com/szw/vim-g ~/.vim/bundle/vim-g || print -P %F{001}Failed to install vim-g%f
fi

if [[ -a ~/.vim/autoload/plug.vim && ( ! -d ~/.vim/plugged/nerdcommenter || ! -d ~/.vim/plugged/vim-go ) ]]
then
  vim +PlugInstall +qall
fi

if [[ -a ~/.vim/bundle/vimpager ]]
then
  export PAGER=vimpager
else
  export PAGER=less
fi

export PROMPT='%(?.%F{006}.%F{001})%B(%b%f%?%(?.%F{006}.%F{001})%B)%b%n%F{006}%B@%b%f%m%F{006}%B:%b%f%~%F{006}%B%#%b%f '
export EDITOR=vim
export DOTFILES=$HOME/dotfiles
export PDFVIEWER=evince
export IMAGEVIEWER=display

hash -d D=$DOTFILES
hash -d G=$GOPATH
hash -d T=$GOPATH/src/github.com/thomasheller
hash -d TH=$HOME/thme/thomasheller-hugo
hash -d W=$HOME/Downloads

alias D="cd ~D"
alias G="cd ~G"
alias T="cd ~T"
alias TH="cd ~TH"
alias W="cd ~W"

alias Dpl='cd ~D && Gpl'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias .s="$EDITOR $DOTFILES/screenrc"
alias .t="$EDITOR $DOTFILES/tmux.conf"
alias .v="$EDITOR $DOTFILES/vimrc"
alias .z="$EDITOR $DOTFILES/zshrc"
alias 700='chmod -R 0700'
alias 600='chmod -R 0600'
alias 755='chmod -R 0755'
alias 644='chmod -R 0644'
alias ai='sudo apt-get install'
alias ac='apt-cache search'
alias md=mkdir
alias rd=rmdir
alias c=cat
alias calc='bc -lq' # use scale=n to set precision manually
alias cp='cp -i'
alias disp=$IMAGEVIEWER
alias h=head
alias g=grep
alias gb='go build'
alias gg='go get'
alias gt='go test'
alias gi='grep -i'
alias gl='grep -l'
alias gil='grep -il'
alias gv='grep -v'
alias gw='grep -w'
alias l=ls
alias la='ls -a'
alias ll='ls -l'
alias lart='ls -lart'
alias mpl='mplayer'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias mv='mv -i'
alias now='date +%Y-%m-%d-%H%M%S-%Z'
alias rm='rm -i'
alias t=tail
alias v=vim
alias vd=vimdiff
alias p='print -l'
alias reds='redshift -t 6500:1000'
alias sshproxy='ssh -v -D 8080 -C -N'
alias src="source $DOTFILES/zshrc"
alias wl='wc -l'
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
alias Gshowremote='git remote -v'
alias Gt='git tag'

alias -s gz='tar ztf' # TODO: should check for tar.gz
alias -s tar='tar tf'
alias -s tgz='tar ztf'
alias -s zip='unzip -l'
alias -s jpg=$IMAGEVIEWER
alias -s png=$IMAGEVIEWER
alias -s pdf=$PDFVIEWER

function Gours() {
  git checkout --ours $@ && git add $@
}

function Gtheirs() {
  git checkout --theirs $@ && git add $@
}

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
  sudo apt-get install chromium-browser gimp inkscape imagemagick virtualbox-guest-dkms texmaker meld redshift evince aterm libreoffice
}

function go64() {
  GOARCH=amd64 GOOS=linux go $@
}

function chromium-fake-media() {
  chromium-browser --use-fake-ui-for-media-stream --use-fake-device-for-media-stream
}

function replace() {
  local search
  local replace
  search=$1
  replace=$2
  shift 2
  echo sed -i -- "s/$search/$replace/g" $@
  echo -n "OK? (y/n) "
  read line
  if [[ $line == "y" ]]
  then
    echo Replacing...
    sed -i -- "s/$search/$replace/g" $@
  fi
}

function bis() {
  for x in $@
  do
    bower install --save $x
  done
}

bindkey jj vi-cmd-mode
bindkey '^R' history-incremental-search-backward

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
setopt nohup

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
checkdotfile tmux.conf

# check if ~/dotfiles is up-to-date with GitHub:
function syncdotfiles {
  git -C $DOTFILES fetch origin || return
  if ! git -C $DOTFILES diff origin/master --exit-code >/dev/null
  then
    echo Dotfiles in origin/master have changed:
    git -C $DOTFILES status
    echo Type 'Dpl' to pull changes from remote repository.
  fi
}

if [[ $TERM == screen ]]
then
  echo Type \`syncdotfiles\' to sync dotfiles
else
  syncdotfiles
fi

if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
  source $HOME/google-cloud-sdk/path.zsh.inc
fi
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
  source $HOME/google-cloud-sdk/completion.zsh.inc
fi

if [[ -a ~/.zshrc.local ]]
then
  source ~/.zshrc.local
fi

function hn() {
  for i in $@
  do
    (cd ~/sivm/sivananda-marga/ && hugo new $i.md)
  done
}
