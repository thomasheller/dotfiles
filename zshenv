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

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

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

alias alpine='docker run -it --rm alpine ash'

alias bc='bc -ql'

alias c=cat
alias colors='msgcat --color=test'

alias Dup='(cd ~T/dotfiles && git fetch && git rebase origin/master && ./symlinks.sh) && src'

alias f='for i in'
alias fn='noglob find -iname'

alias G=git
alias Ga='git add'
alias Gamend='git commit --amend'
alias Gap='git add -p'
alias Gau='git add -u'
alias Gb='git branch'
alias Gc='git clone'
function Gcd() {
	case $# in
		1) git clone "$1" && cd "$(basename "$1" .git)" ;;
		2) git clone "$1" "$2" && cd "$2" ;;
		*) echo "usage: $0 <repository> [<directory>]" ;;
	esac
}
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
alias Gr='git rebase'
alias Gre='git reset'
alias Gresethardmaster='git fetch origin && git reset --hard origin/master && git clean -df'
alias Grm='git rm'
alias Gs='git status'
alias Gsh='git show'
alias Gshowremote='git remote -v'
alias Gstashapply0='git stash apply stash@{0}'
alias Gt='git tag'
alias Gundo='git reset --soft HEAD~1'
alias Gup='git checkout master && git fetch upstream && git rebase upstream/master && git push origin master'
alias Gw='git ls-files -m -o | grep -v '\.sw.$'' # display files currently being worked on
function Gours() { git checkout --ours $@ && git add $@ }
function Gtheirs() { git checkout --theirs $@ && git add $@ }

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
alias gb='eval $(gimme stable) && go build'
alias gbpi='eval $(gimme stable) && GOOS=linux GOARCH=arm GOARM=7 go build'
alias gd='eval $(gimme stable) && go doc'
alias gco='eval $(gimme stable) && go test -coverprofile=coverage.out && go tool cover -html=coverage.out'
alias gg='eval $(gimme stable) && go get'
alias golint='gometalinter --enable-all'
alias gt='eval $(gimme stable) && go test'
alias gv='eval $(gimme stable) && go vet'

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
function mcd() { mkdir -pv $@ && cd $1 } # create dir(s) and cd (to the first)

alias m=mplayer
alias mpl=mplayer

alias p='print -l'

alias rd=rmdir

alias src="source $HOME/.zshenv && source $HOME/.zshrc"
alias stop='sync && sudo shutdown -h now'
alias strip-colors='perl -pe "s/\e\[?.*?[\@-~]//g"'
alias sx='cd && exec startx -- -nolisten tcp'

alias t=tail
alias t0f='tail -n 0 -f'
alias tf='tail -f'
alias tree='tree -C'

alias utf8test='curl -s https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'

alias v=vim
alias vd=vimdiff
alias vo='vim -o'
alias vO='vim -O'

alias wl='wc -l'

alias zmv='noglob zmv'

# }}}

# NAMED DIRECTORIES {{{

hash -d D=$HOME/Documents
hash -d DF=$GOPATH/src/github.com/thomasheller/dotfiles
hash -d G=$GOPATH/src
hash -d GH=$GOPATH/src/github.com
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

