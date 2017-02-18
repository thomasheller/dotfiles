# ==============================================================================
# ~/.zshenv -- configuration file for Zsh (<http://zsh.org>) by Thomas Heller
# Latest version: <https://github.com/thomasheller/dotfiles/>
# ==============================================================================

# Define aliases that are safe for non-interactive shells, for expamle
# when executing commands from Vim.

# shell essentials:
alias c=cat
alias h=head
alias t=tail

# directory management:
alias md=mkdir
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
function Gours() { git checkout --ours $@ && git add $@ }
function Gtheirs() { git checkout --theirs $@ && git add $@ }

# grep:
alias g='grep --color=auto'
alias gi='grep -i'
alias gl='grep -l'
alias gil='grep -il'
alias gv='grep -v'
alias gw='grep -w'

# Go-related aliases:
alias gb='go build'
alias gco='go test -coverprofile=coverage.out && go tool cover -html=coverage.out'
alias gg='go get'
alias gt='go test'

# ls:
alias l=ls
alias la='ls -a'
alias ll='ls -l'
alias lart='ls -lart'

