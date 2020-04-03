# ~/.zshrc (env, aliases and named directories are in ~/.zshenv)

# SUFFIX ALIASES {{{

alias -s pdf=$READER
for i in gif jpg jpeg; alias -s $i=$IMAGEVIEWER
for i in odt doc docx ods xls xlsx; alias -s $i=$OFFICE

# }}}

# PROMPT {{{

autoload -Uz vcs_info

precmd() { vcs_info }

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' actionformats ' %b %c %u (%a) '
zstyle ':vcs_info:git:*' formats ' %c%u %b '
zstyle ':vcs_info:git:*' stagedstr "*"
zstyle ':vcs_info:git:*' unstagedstr "*"

# Conditional Unicode prompt:
# - cross icon if exit status != 0
# - gear icon if job(s) running
# - user and hostname if SSH_CONNECTION
# - dirty state if Git repository
# - branch name if Git repository
# - lightning icon and username if UID == 0

setopt promptsubst

export PROMPT='%(?..%F{black}%K{red} '$'\u274c'' %? %k%f)\
%(1j.%F{black}%K{green} '$'\u2699'' %j %k%f.)\
%K{blue}%F{black} \
${SSH_CONNECTION+%n@%m:}\
%~\
 %f%k\
%F{black}%K{yellow}${${${vcs_info_msg_0_/\*\*/*}/\*/'$'\U0001f6a7''}/.../ '$'\u2754''}%k%f\
%(!.%F{yellow} %n '$'\u26a1''%f.%K{black}%F{white}'$'\u2b9e''%k%f) '

# }}}

# OPTIONS {{{

setopt autocd
setopt extendedglob
setopt interactivecomments
setopt histignorespace

REPORTTIME=5

# }}}

# KEY BINDINGS {{{

bindkey -v # Vi mode

zle -N insert-glob-all-non-dirs
zle -N insert-last-command-output-or-edit-git-workspace-magic
zle -N ls-or-accept-line
zle -N restore-last-parameters

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^M' ls-or-accept-line
bindkey '^R' history-incremental-search-backward
bindkey '^Z' restore-last-parameters
bindkey '^[[19~' insert-glob-all-non-dirs # F8
bindkey '^[[24~'  insert-last-command-output-or-edit-git-workspace-magic # F12
bindkey jj vi-cmd-mode

function insert-glob-all-non-dirs {
  LBUFFER=$LBUFFER'**/*(^/) '
}

function insert-last-command-output-or-edit-git-workspace-magic {
	local selection
	local fzf_cmd
	
	fzf_cmd=($HOME/.fzf/bin/fzf --exit-0 --tac --cycle -m --filepath-word --select-1)

	if [[ -n "$BUFFER" ]]; then
		selection=$(eval $history[$((HISTCMD-1))] | $fzf_cmd | paste -s -d' ')
		if [[ -n "$selection" ]]; then
			LBUFFER+="$selection"
		fi
	else
		selection="$(Gw | $fzf_cmd | paste -s -d' ')" || return
		if [[ -n "$selection" ]]; then
			BUFFER="v $selection"
			zle accept-line
		fi
	fi
}

function ls-or-accept-line {
  if [[ $#BUFFER -eq 0 ]]; then
    # BUFFER=l
    # BUFFER=ll
    # BUFFER='lart -h'
    BUFFER=' ls -1'
  fi
  zle accept-line
}

function restore-last-parameters {
  zle kill-buffer
  zle up-history
  zle beginning-of-line
  zle kill-word
}

# }}}

# TODO

autoload -U zmv
autoload -U compinit

if has vimpager; then
	export PAGER=vimpager
else
	export PAGER=less
fi

if [[ $TERM == dumb ]]; then
	unset zle_bracketed_paste
fi

