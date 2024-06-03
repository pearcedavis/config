# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias open='xdg-open'
alias tf='terraform'
alias tfw='terraform workspace'
alias awsve='aws-vault exec --session-ttl=8h --assume-role-ttl=1h'
alias gg='git grep'
alias ggg='git -C $(git root) grep'
alias g='git'
alias gs='git status'
alias gcd='cd $(git root)'
alias v='vim'

# git style diff
alias diff='diff --color -u'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function mkcd {
	mkdir -p $1 && cd $1
}

function reload {
	source ~/.bashrc
}

function update_tmux_status {
	# set window title to git branch
	# branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	# printf '\033]2;%s\033\\' "${branch}"

	# refresh tmux status line
	tmux refresh-client -S
}

# bright colours
BLACK="\[\033[01;30m\]"
RED="\[\033[01;31m\]"
GREEN="\[\033[01;32m\]"
BROWN="\[\033[01;33m\]"
BLUE="\[\033[01;34m\]"
PURPLE="\[\033[01;35m\]"
CYAN="\[\033[01;36m\]"
GREY="\[\033[01;37m\]"
RESET_COLOUR="\[\033[00m\]"

function build_prompt {
	# history -a; history -c; history -r;
	repo_dir=$(git rev-parse --show-toplevel 2>/dev/null)
	if [ -z "$repo_dir" ]; then
		# need to set default prompt in case we just left a repo
		export PS1="${BLUE}\w > ${RESET_COLOUR}"
	else
		repo_name=$(basename "$repo_dir" 2>/dev/null)
		# path relative to git repo root
		rel_path=$(realpath --relative-to=$repo_dir $PWD)

		# gridshare env and region
		gs_env_reg=""
		# if [ "$repo_name" = "gridshare-edge" ]; then
		# 	env=$(awk '/stage/{ print $2 }' "${repo_dir}/.environment-config.yml" )
		# 	reg=$(awk '/region/{ print $2 }' "${repo_dir}/.environment-config.yml" )
		# 	gs_env_reg=" (${env}/${reg})"
		# fi

		repo_display=""
		if [[ $TMUX ]]; then
			# refresh tmux status line
	        	tmux refresh-client -S
			# no branch name because we have that in tmux status
			repo_display=$repo_name
		else
			# add branch name when not in tmux
			branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
			repo_display="${repo_name}[$branch]"
		fi
		export PS1="${GREEN}${repo_display}:${BLUE}${rel_path}${BROWN}${gs_env_reg}${BLUE} > ${RESET_COLOUR}"
	fi
}

function fix_ssh_vars {
	# fix ssh vars after direnv
	export SSH_AGENT_PID=$(pidof ssh-agent)
	export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/openssh_agent"
}

# prompt
PROMPT_DIRTRIM=2
PS1="${BLUE}\w > ${RESET_COLOUR}"
# PROMPT_COMMAND="build_prompt;fix_ssh_vars"
PROMPT_COMMAND="build_prompt"

export EDITOR="vim"
export TERMINAL="konsole"
export PAGER="less"
# display accented characters properly in things like git log
export LESSCHARSET="utf-8"
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# aws sdk sso support
export AWS_SDK_LOAD_CONFIG=1

# ssh-agent
# eval $(keychain --noask --timeout 60 --eval --quiet ~/.ssh/id_rsa)
# pidof ssh-agent >/dev/null || ssh-agent -s -t 3600 > "$XDG_RUNTIME_DIR/ssh-agent.env"
# source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null 2>&1

# fzf
source /usr/share/doc/fzf/examples/key-bindings.bash
function gdiff {
	# base=$(git branch --all | grep -v HEAD | sed -e "s/.* //" -e "s:remotes/::" | fzf)
	git diff $@ --name-only | fzf --multi --ansi --preview "git diff $@ --color=always -- {-1}"
}

function gch {
	base=$(git branch --all | grep -v HEAD | sed -e "s/.* //" -e "s:remotes/[^/]*/::" | fzf)
	git checkout $base $@
}

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
. "$HOME/.cargo/env"
