# ==============================================================================
# ~/.zshrc -- configuration file for Zsh (<http://zsh.org>) by Thomas Heller
# Latest version: <https://github.com/thomasheller/dotfiles/>
# ==============================================================================

export GOPATH=$HOME/go  # default as of Go 1.8

typeset -U path
path+=/usr/local/go/bin
path+=/usr/lib/go/bin
path+=$GOPATH/bin
path+=$HOME/bin
path+=$HOME/.vim/bundle/vimpager

# ========================================================================== {{{
# Install useful stuff
# ==========================================================================

# warn tells the user about install problems in red color.
function warn() {
  print -P "%F{001}$@%f"
}

# has checks if a command is (several commands are) currently available.
# Helper function for installing useful stuff.
# usage:
# has [COMMAND]...
function has() {
  for cmd in $@; do
    if ! command -v $cmd >/dev/null; then
      return 1
    fi
  done
  return 0
}

function install_everything() {
  # Let's see what's available through package management.
  local -A cmds # commands and their packages
  cmds+=(bzip2 bzip2) # includes bunzip2
  cmds+=(ctags exuberant-ctags)
  cmds+=(curl curl)
  cmds+=(dot graphviz)
  cmds+=(git git)
  cmds+=(gnuplot gnuplot)
  cmds+=(go golang)
  cmds+=(ncdu ncdu)
  cmds+=(netcat netcat-openbsd)
  cmds+=(nmap nmap)
  cmds+=(npm npm)
  cmds+=(pdfgrep pdfgrep)
  cmds+=(tmux tmux)
  cmds+=(tree tree)
  cmds+=(vim vim)
  cmds+=(zip unzip)
  cmds+=(zip zip)
  cmds+=(zsh zsh) # should be installed already
  local -a to_be_installed
  for cmd in ${(@k)cmds}; do
    if ! has $cmd; then
      to_be_installed+=$cmds[$cmd]
    fi
  done
  if [[ ${#to_be_installed} > 0 ]]; then
    if has apt-get; then
      echo "The following packages are missing, installing:"
      echo $to_be_installed
      sudo apt-get install $to_be_installed
    else
      warn "Could not install the following packages because apt-get is missing:"
      warn $to_be_installed
    fi
  fi
  unset to_be_installed

  # Install Go-related/Go-powered tools using `go get` if Go is available.
  local -a go_tools
  go_tools+=github.com/GoASTScanner/gas
  go_tools+=github.com/alecthomas/gocyclo
  go_tools+=github.com/client9/misspell/cmd/misspell
  go_tools+=github.com/godoctor/godoctor
  go_tools+=github.com/golang/lint/golint
  go_tools+=github.com/gordonklaus/ineffassign
  go_tools+=github.com/jgautheron/goconst/cmd/goconst
  go_tools+=github.com/jmhodges/jsonpp
  go_tools+=github.com/jstemmer/gotags
  go_tools+=github.com/kisielk/errcheck
  go_tools+=github.com/mailgun/godebug
  go_tools+=github.com/mdempsky/unconvert
  go_tools+=github.com/mibk/dupl
  go_tools+=github.com/mvdan/interfacer/cmd/interfacer
  go_tools+=github.com/ncw/rclone
  go_tools+=github.com/opennota/check/cmd/aligncheck
  go_tools+=github.com/opennota/check/cmd/structcheck
  go_tools+=github.com/opennota/check/cmd/varcheck
  go_tools+=github.com/stripe/safesql
  go_tools+=github.com/thomasheller/2
  go_tools+=github.com/thomasheller/multigoogle
  go_tools+=github.com/tsenart/deadcode
  go_tools+=github.com/walle/lll/cmd/lll
  go_tools+=golang.org/x/tools/cmd/godoc
  go_tools+=golang.org/x/tools/cmd/goimports
  go_tools+=golang.org/x/tools/cmd/gotype
  go_tools+=golang.org/x/tools/cmd/guru
  go_tools+=golang.org/x/tools/cmd/present
  go_tools+=honnef.co/go/simple/cmd/gosimple
  go_tools+=honnef.co/go/staticcheck/cmd/staticcheck
  go_tools+=honnef.co/go/unused/cmd/unused
  local -a to_be_installed
  for tool in $go_tools; do
    if ! has ${tool:t}; then
      to_be_installed+=$tool
    fi
  done
  if [[ ${#to_be_installed} > 0 ]]; then
    if has go; then
      echo "The following Go-related commands are missing, installing:"
      echo $to_be_installed
      for p in $to_be_installed; do
	go get $p
      done
    else
      warn "Could not install from the following paths because Go is missing:"
      warn $to_be_installed
    fi
  fi
  unset to_be_installed

  # Install some tools through npm, if npm is available.
  local -A npm_tools
  npm_tools+=(bower bower)
  npm_tools+=(markdown markdown-to-html)
  local -a to_be_installed
  for tool in ${(@k)npm_tools}; do
    if ! has $tool; then
      to_be_installed+=$npm_tools[$tool]
    fi
  done
  if [[ ${#to_be_installed} > 0 ]]; then
    if has npm; then
      echo "The following npm tools are missing, installing:"
      echo $to_be_installed
      sudo npm install $to_be_installed -g
    else
      warn "Could not install the following because npm is missing:"
      warn $to_be_installed
    fi
  fi
  unset to_be_installed

  # Install Pathogen for Vim plug-in management.
  if [[ ! -a ~/.vim/autoload/pathogen.vim ]]; then
    echo "Pathogen is not available, installing."
    mkdir -p ~/.vim/autoload
    mkdir -p ~/.vim/bundle
    wget -nv -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  fi

  # Fetch some Vim plug-ins using Git if Git is available. They will be
  # installed through Pathogen when Vim is launched.
  local -a pathogen_plugins
  pathogen_plugins+=fatih/vim-go
  pathogen_plugins+=godoctor/godoctor.vim
  pathogen_plugins+=kshenoy/vim-signature
  pathogen_plugins+=majutsushi/tagbar
  pathogen_plugins+=rkitover/vimpager
  pathogen_plugins+=scrooloose/nerdcommenter
  pathogen_plugins+=szw/vim-g
  pathogen_plugins+=will133/vim-dirdiff
  local -a to_be_installed
  for plugin in $pathogen_plugins; do
    if [[ ! -a ~/.vim/bundle/${plugin:t} ]]; then
      to_be_installed+=$plugin
    fi
  done
  if [[ ${#to_be_installed} > 0 ]]; then
    if has git; then
      echo "The following Vim plug-ins are missing, installing:"
      echo $to_be_installed
      for r in $to_be_installed; do
	git clone https://github.com/$r ~/.vim/bundle/${r:t}
      done
    else
      warn "Could not clone the following repos because Git is missing:"
      warn $to_be_installed
    fi
  fi
  unset to_be_installed
}

install_everything

# ========================================================================== }}}

if has vimpager; then
  export PAGER=vimpager
else
  export PAGER=less
fi

export PROMPT='%(?.%F{006}.%F{001})%B(%b%f%?%(?.%F{006}.%F{001})%B)%b%n%F{006}%B@%b%f%m%F{006}%B:%b%f%~%F{006}%B%#%b%f '
export EDITOR=vim
export DOTFILES=$HOME/dotfiles
export PDFVIEWER=evince
export IMAGEVIEWER=display
export OFFICE=libreoffice

hash -d D=$DOTFILES
hash -d G=$GOPATH/src
hash -d S=$HOME/Store
hash -d T=$GOPATH/src/github.com/thomasheller
hash -d TH=$HOME/thme/thomasheller-hugo
hash -d W=$HOME/Downloads

alias f='for i in'

alias D="cd ~D"
alias G="cd ~G"
alias T="cd ~T"
alias TH="cd ~TH"
alias W="cd ~W"

alias Dd="git -C $DOTFILES diff"
alias Dpl="git -C $DOTFILES pull"
alias Ds="git -C $DOTFILES status"

alias sx='startx -- -nolisten tcp' # start X for local use

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias .s="$EDITOR $DOTFILES/screenrc"
alias .t="$EDITOR $DOTFILES/tmux.conf"
alias .v="$EDITOR $DOTFILES/vimrc"
alias .z="$EDITOR $DOTFILES/zshrc"
alias .ze="$EDITOR $DOTFILES/zshenv"
alias ai='sudo apt-get install'
alias ac='apt-cache search'
alias calc='bc -lq' # use scale=n to set precision manually
alias disp=$IMAGEVIEWER
alias mpl='mplayer'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias now='date +%Y-%m-%d-%H%M%S-%Z'
# if [[ $TERM == screen ]]; then
#   if [ -n "${TMUX+x}" ]; then
#     alias vim='tmux new-window vim'
#   else
#     alias vim='screen vim'
#   fi
# fi
alias v=vim
alias vd=vimdiff
alias vo='vim -o'
alias vO='vim -O'
alias p='print -l'
alias reds='redshift -t 6500:1000'
alias sshproxy='ssh -v -D 8080 -C -N'
alias src="source $DOTFILES/zshenv && source $DOTFILES/zshrc"
alias wl='wc -l'

alias -s gz='tar ztf' # TODO: should check for tar.gz
alias -s tar='tar tf'
alias -s tgz='tar ztf'
alias -s zip='unzip -l'
alias -s jpg=$IMAGEVIEWER
alias -s png=$IMAGEVIEWER
alias -s pdf=$PDFVIEWER
alias -s odt=$OFFICE # Writer
alias -s doc=$OFFICE
alias -s docx=$OFFICE
alias -s ods=$OFFICE # Calc
alias -s xls=$OFFICE
alias -s xlsx=$OFFICE

if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
fi

alias img2pdf="convert -compress jpeg -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"
alias img2pdf_gray="convert -compress jpeg -colorspace gray -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"
alias img2pdf_mono="convert -compress jpeg -monochrome -resize 1240x1753 -extent 1240x1753 -gravity center -units PixelsPerInch -density 150x150"

alias outlook="java -jar ~/outlook/MSGViewer-1.9/MSGViewer.jar"
alias zettelkasten='java -jar /usr/local/bin/Zettelkasten.jar'

function provision-gui() {
  sudo apt-get install chromium-browser gimp inkscape imagemagick jhead virtualbox-guest-dkms texmaker meld redshift evince aterm libreoffice
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
setopt completealiases

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

local -a dotfiles
dotfiles=(zshenv zshrc vimrc screenrc tmux.conf)
for repofile in $dotfiles; do
  local dotfile=.$repofile
  if [[ ! -a ~/$dotfile ]]
  then
    # echo ~/$dotfile does not exist, symlinking to $DOTFILES/$repofile
    ln -s $DOTFILES/$repofile ~/$dotfile
  else if [[ $(realpath ~/$dotfile) != $DOTFILES/$repofile ]]
  then
    print -P %F{001}~/$dotfile exists, but is not a symlink to ~/dotfiles/$repofile%f
  fi
  fi
done

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

function zshexit() {
  cd ~D
  if ! Gs | grep "up-to-date with 'origin/master'"
  then
    echo "Maybe you wanted to push your dotfiles?"
    echo
    Gs
    echo
    echo "Press enter to return to a shell."
    echo "Press ^C if you really want to quit."
    read line
    exec zsh
  fi
}

