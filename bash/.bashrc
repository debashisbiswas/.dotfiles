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
HISTSIZE=1000
HISTFILESIZE=2000

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
force_color_prompt=yes

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
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

export LS_COLORS="ow=01;34;40"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# colors
# https://github.com/shawn-sterling/bashsoup/blob/master/prompt.sh
export PS1_GREY="\[$(tput bold; tput setaf 0)\]"
export PS1_GREEN="\[$(tput bold; tput setaf 2)\]"
export PS1_YELLOW="\[$(tput bold; tput setaf 3)\]"
export PS1_MAGENTA="\[$(tput bold; tput setaf 5)\]"
export PS1_CYAN="\[$(tput bold; tput setaf 6)\]"
export PS1_WHITE="\[$(tput bold; tput setaf 7)\]"
export PS1_RED="\[$(tput bold; tput setaf 1)\]"
export PS1_RESET="\[$(tput sgr0)\]"

export GIT_PROMPT_DIRTY="±"
export GIT_PROMPT_UNTRACKED="+"
export GIT_PROMPT_CLEAN=""

__git_ps1 () {
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    printf "%s" "${b##refs/heads/}";
  fi
}

__parse_git_status () {
  gitstat=$(git status 2>/dev/null | grep '\(Untracked\|Changes\|Changed but not updated:\|modified:\)')

  if [[ $(echo ${gitstat} | grep -c "^Changes to be committed:\|modified:") > 0 ]]; then
        echo -n "$GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(Untracked files:\|Changed but not updated:\)") > 0 ]]; then
        echo -n "$GIT_PROMPT_UNTRACKED"
  fi

  if [[ $(echo ${gitstat} | wc -l | tr -d ' ') == 0 ]]; then
        echo -n "$GIT_PROMPT_CLEAN"
  fi
}

# function to set PS1
function _bash_prompt() {
    # git info
    local GIT_INFO=$(git branch &>/dev/null && echo "${PS1_GREY}on ${PS1_CYAN}$(__git_ps1 '%s')${PS1_WHITE}$(__parse_git_status)")
    # add <esc>k<esc>\ to PS1 if screen is running
    # see man(1) screen, section TITLES for more
    if [[ "$TERM" == screen* ]]; then
        local SCREEN_ESC='\[\ek\e\\\]'
    else
        local SCREEN_ESC=''
    fi

    PS1="\n${PS1_MAGENTA}\u ${PS1_GREY}at${PS1_YELLOW} \h ${PS1_GREY}in${PS1_GREEN} \w ${GIT_INFO}\
         \n${SCREEN_ESC}${PS1_WHITE}\\\$${PS1_RESET} "
}

# call _bash_prompt() each time the prompt is refreshed
export PROMPT_COMMAND=_bash_prompt

