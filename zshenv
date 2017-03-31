# ==============================================================================
# ~/.zshenv -- configuration file for Zsh (<http://zsh.org>) by Thomas Heller
# Latest version: <https://github.com/thomasheller/dotfiles/>
# ==============================================================================

# Define aliases that are safe for non-interactive shells, for example
# when executing commands from Vim.

# shell essentials:
alias c=cat
alias h=head
alias t=tail

# directory management:
alias md=mkdir
alias mdp='mkdir -p'
alias rd=rmdir
function mcd() { mkdir -p $@ && cd $1 } # create dir(s) and cd (to the first)

# make cp, mv and rm interactive by default:
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# permission management:
alias 700='chmod -R 0700'
alias 600='chmod -R 0600'
alias 755='chmod -R 0755'
alias 644='chmod -R 0644'

# Git:
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
alias Gr='git reset'
alias Gresethardmaster='git fetch origin && git reset --hard origin/master && git clean -df'
alias Grm='git rm'
alias Gs='git status'
alias Gsh='git show'
alias Gshowremote='git remote -v'
alias Gt='git tag'
function Gours() { git checkout --ours $@ && git add $@ }
function Gtheirs() { git checkout --theirs $@ && git add $@ }

# grep:
alias g='grep --color=auto'
alias gi='g -i'
alias gl='g -l'
alias gil='g -il'
alias gv='g -v'
alias gw='g -w'

# Go-related aliases:
alias gb='go build'
alias gco='go test -coverprofile=coverage.out && go tool cover -html=coverage.out'
alias gg='go get'
alias golint='gometalinter --enable-all'
alias gt='go test'

# ls:
alias l=ls
alias la='ls -a'
alias ll='ls -l'
alias lart='ls -lart'
alias big='ls -lSrh'

# zmv:
autoload -U zmv
alias zmv='noglob zmv'

# globbing preferences:
alias mgo='noglob multigoogle'

# global aliases:
alias -g 2nul='2>/dev/null'

# gnuplot, graphviz:
#
# plot function(s) given on the command line, e.g.:
#   $ plot 'sin(x),cos(x+.5*pi),abs(x)'
function plot() {
  gnuplot -persist <<EOF
    set style line 1 lc rgb '#0066aa' lt 1 lw 1 pt 7 ps 1
    plot $1 ls 1 
EOF
}

# plot a directed graph given on the command line, e.g.:
#   $ plotdg 'a->b a->c'
function plotdg() {
  local tmp=$(mktemp /tmp/graphviz.XXXXXXXXXX)
  dot -Tpng -o $tmp <<EOF && echo $tmp && display $tmp
    digraph { $@ }
EOF
}
#
# plot a directed graph from a file, e.g.:
#   $ cat >/tmp/digraph.dat
#   a->b
#   a->c
#   ^D
#   $ plotdgf /tmp/digraph.dat
function plotdgf() {
  local tmp=$(mktemp /tmp/graphviz.XXXXXXXXXX)
  echo "digraph { $(cat $1) }" | dot -Tpng -o $tmp && echo $tmp && display $tmp
}

# plot values from a file as a line graph with points, e.g.:
#   $ cat >/tmp/graph.dat
#   1 2.25
#   2 1
#   3 4
#   ^D
#   $ plotlpf /tmp/graph.dat
function plotlpf() {
  gnuplot -persist <<EOF
    set style line 1 lc rgb '#0066aa' lt 1 lw 1 pt 7 ps 1
    plot "$1" with linespoints ls 1
EOF
}

# plot CSV file data as a line graph with points, e.g.:
#   $ cat >/tmp/graph.csv
#   1,2.25
#   2,1
#   3,4
#   ^D
#   $ plotlpcsv /tmp/graph.csv
function plotlpcsv() {
  gnuplot -persist <<EOF
    set style line 1 lc rgb '#0066aa' lt 1 lw 1 pt 7 ps 1
    set datafile separator ","
    plot "$1" with linespoints ls 1
EOF
}

# Docker containers:
alias DO='docker run -it --rm ubuntu /bin/bash -c "cd && exec bash"'
alias DOz='docker run -it --rm ubuntu /bin/bash -c "apt-get -qq update && apt-get install -qq git sudo zsh >/dev/null && cd && exec zsh"'
alias DOth='docker run -it --rm ubuntu /bin/bash -c "apt-get -qq update && apt-get install -qq git sudo zsh >/dev/null && cd && git clone https://github.com/thomasheller/dotfiles && zsh dotfiles/zshall && exec zsh"'
