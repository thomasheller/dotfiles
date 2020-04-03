# ~/.zshenv (also read by Vim)

# ENVIRONMENT {{{

# Set Golang development path
# This is the default as of Go 1.8 but we need this variable in some other places.
export GOPATH=$HOME/go

# Set PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin

# Default applications
export BROWSER=chromium-browser
export EDITOR=vim
export IMAGEVIEWER=sxiv
export OFFICE=libreoffice
export READER=zathura

# Application specific settings
export LESS=-R

# Application specific configuration paths
# export ZDOTDIR=$HOME/.config/zsh
# export ZDOTDIR=$HOME

export ANDROID_HOME=$HOME/Android/Sdk

# }}}

# ALIASES and FUNCTIONS (alphabetically) {{{

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias -- +x='chmod +x'
alias -- -x='chmod -x'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

# see also symlinks.sh
alias .a="$EDITOR $HOME/.config/alacritty/alacritty.yml"
alias .b="$EDITOR $HOME/.config/bspwm/bspwmrc"
alias .p="$EDITOR $HOME/.config/polybar/config"
alias .s="$EDITOR $HOME/.screenrc"
alias .sx="$EDITOR $HOME/.config/sxhkd/sxhkdrc"
alias .t="$EDITOR $HOME/.tmux.conf"
alias .v="$EDITOR $HOME/.vim/vimrc"
alias .xi="$EDITOR $HOME/.xinitrc"
alias .xm="$EDITOR $HOME/.Xmodmap"
alias .z="$EDITOR $HOME/.zshrc"
alias .ze="$EDITOR $HOME/.zshenv"

alias 600='chmod -R 0600'
alias 644='chmod -R 0644'
alias 700='chmod -R 0700'
alias 755='chmod -R 0755'

alias Ga='git add'
alias Gau='git add -u'
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
alias Gmv='git mv'
alias Gpl='git pull'
alias Gpo='git push origin'
alias Gpoh='git push origin HEAD'
alias Gr='git reset'
alias Gresethardmaster='git fetch origin && git reset --hard origin/master && git clean -df'
alias Grm='git rm'
alias Gs='git status'
alias Gsh='git show'
alias Gshowremote='git remote -v'
alias Gstashapply0='git stash apply stash@{0}'
alias Gt='git tag'
alias Gup='git checkout master && git fetch upstream && git rebase upstream/master && git push origin master'
alias Gw='git ls-files -m -o | grep -v '\.sw.$'' # display files currently being worked on
function Gours() { git checkout --ours $@ && git add $@ }
function Gtheirs() { git checkout --theirs $@ && git add $@ }

alias c=cat

alias f='for i in'
alias fn='noglob find -iname'

# grep with color for piping to less -R
alias g='grep --color=always'
alias gi='g -i'
alias gl='g -l'
alias gil='g -il'
alias gv='g -v'
alias gw='g -w'
alias gr='g -r'
alias grl='g -rl'
alias gri='g -ri'
alias gril='g -ril'

# raw grep without color
alias rg='grep --color=none'
alias rgi='rg -i'
alias rgl='rg -l'
alias rgil='rg -il'
alias rgv='rg -v'
alias rgw='rg -w'
alias rgr='rg -r'
alias rgrl='rg -rl'
alias rgri='rg -ri'
alias rgril='rg -ril'


# Go-related aliases:
alias gb='go build'
alias gd='go doc'
alias gco='go test -coverprofile=coverage.out && go tool cover -html=coverage.out'
alias gg='go get'
alias golint='gometalinter --enable-all'
alias gt='go test'
alias gv='go vet'

alias h=head

function has() {
	for cmd in $@; do
	if ! command -v "$cmd" >/dev/null; then
		return 1
	fi
	done
	return 0
}

# ls:
if [[ -x /usr/bin/dircolors && -f $HOME/.dircolors ]]; then
	eval $(/usr/bin/dircolors $HOME/.dircolors)
	alias ls='ls --color=auto'
fi
alias l=ls
alias l1='ls -1'
alias la='ls -a'
alias lart='ls -lart'
alias ll='ls -l'
alias lsd='ls -d'

alias md=mkdir
function mcd() { mkdir -p $@ && cd $1 } # create dir(s) and cd (to the first)

alias m=mplayer
alias mpl=mplayer

alias p='print -l'

alias rd=rmdir

alias src="source $HOME/.zshenv && source $HOME/.zshrc"
alias stop='sudo shutdown -h now'
alias sx='exec startx -- -nolisten tcp'

alias t=tail
alias t0f='tail -n 0 -f'
alias tf='tail -f'

alias v=vim
alias vd=vimdiff
alias vo='vim -o'
alias vO='vim -O'

alias wl='wc -l'

alias zmv='noglob zmv'

# }}}

# NAMED DIRECTORIES {{{

hash -d D=$HOME/Documents
hash -d G=$GOPATH/src
hash -d K=$GOPATH/src/github.com/thomasheller/kari-private
hash -d N=$HOME/Nextcloud
hash -d P=$HOME/Projects
hash -d T=$GOPATH/src/github.com/thomasheller
hash -d TH=$HOME/thme/thomasheller.github.io
hash -d W=$HOME/Downloads
hash -d WD=$GOPATH/src/local/webdesk

# }}}

# TODO

stty stop undef
stty start undef

set nosharehistory

setopt extendedglob
setopt nohup
setopt completealiases

if [[ -f $HOME/.zshenv.local ]]; then
	source $HOME/.zshenv.local
fi

