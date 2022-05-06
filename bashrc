#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#################
# GENERAL STUFF #
#################
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
[[ $- != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# source bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# source git completion and set options
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  source /usr/share/git/completion/git-prompt.sh
elif [ -f /usr/lib/git-core/git-sh-prompt ]; then
  source /usr/lib/git-core/git-sh-prompt
fi
if [ -f /usr/share/git/completion/git-prompt.sh ] || [ -f /usr/lib/git-core/git-sh-prompt ]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_COMPLETION="True"
else
  GIT_COMPLETION="False"
fi

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s expand_aliases

# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc so it won't get overriden
if [ ! -a ~/.inputrc ]; then
    echo '$include /etc/inputrc' > ~/.inputrc
fi
# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> ~/.inputrc

# Ensure CTRL + SHIFT + T  opens a new terminal in the same path as the current one
# Following https://unix.stackexchange.com/a/93477
if [ -f "/usr/lib/vte-urlencode-cwd" ]; then
  if [ -f "${HOME}/git/DotFiles/vte.sh" ]; then
    source "${HOME}/git/DotFiles/vte.sh"
  fi
fi

###########
# HISTORY #
###########
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=

##################
# COLOR & PROMPT #
##################
# enable color support of ls, etc.
if [ -x /usr/bin/dircolors ]; then
  if type -P dircolors >/dev/null ; then
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	fi
  fi
  alias ls='ls --color=auto  --group-directories-first'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
else
  alias ls='ls  --group-directories-first'
fi

# bash prompt
if [ "${HOSTNAME}" == "einstein" ] || [ "${HOSTNAME}" == "kleineinstein" ] || \
   [ "${HOSTNAME}" == "badwlrz-cl01399" ]; then
  ISLAPTOP="True"
elif [ "${HOSTNAME}" == "max" ] || [ "${HOSTNAME}" == "mykonos" ] || \
     [ "${HOSTNAME}" == "dell01" ] || [ "${HOSTNAME}" == "dell02" ] || \
     [ "${HOSTNAME}" == "dell03" ] || [ "${HOSTNAME}" == "dell04" ] || \
     [ "${HOSTNAME}" == "smaug" ]; then
  ISLAPTOP="False"
else
  ISLAPTOP=""
fi

if [ "${EUID}" == "0" ] ; then
  if [ "${ISLAPTOP}" == "False" ]; then
    PROMPT_COMMAND=init
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]]\[\033[00m\]\n\$ '
    fi
  elif [ "${ISLAPTOP}" == "True" ]; then
    PROMPT_COMMAND=initlaptop
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]]\[\033[00m\]\n\$ '
    fi
  else
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;31m\]]\[\033[00m\]\n\$ '
    fi
  fi
else
  if [ "${ISLAPTOP}" == "False" ]; then
    PROMPT_COMMAND=init
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]]\[\033[00m\]\n\$ '
    fi
  elif [ "${ISLAPTOP}" == "True" ]; then
    PROMPT_COMMAND=initlaptop
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]]\[\033[00m\]\n\$ '
    fi
  else
    if [ "${GIT_COMPLETION}" == "True" ]; then
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]$(__git_ps1 " (%s)")]\[\033[00m\]\n\$ '
    else
      PS1='\[\033[47;30m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | \u@\h ($(uname -r))][\033[47;32m\]\w\[\033[47;30m\]]\[\033[00m\]\n\$ '
    fi
  fi
fi
unset ISLAPTOP

function promptRAM() {
  RAM="$(free -h | awk 'NR==2 {print $4 "/" $2}')"
}

function promptCPU() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.1
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  CPUUTIL="$((100 * ( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal)))%"
  CPUTEMP=""
  if [ "${USER}" == "sebastian" ]; then
    if [ "${HOSTNAME}" == "max" ]; then
      CPUTEMP=", $(sensors | grep "Tctl" | awk '{print $2}')"
    elif [ "${HOSTNAME}" == "einstein" ]; then
      CPUTEMP=", $(sensors | grep "Package id 0:" | awk '{print $4}')"
    elif [ "${HOSTNAME}" == "kleineinstein" ]; then
      CPUTEMP=", $(sensors | grep "Core 2" | awk '{print $3}')"
    fi
  elif [ "${USER}" == "ga56gix" ]; then
    if [ "${HOSTNAME}" == "mykonos" ]; then
      CPUTEMP=", $(sensors | grep "CPU Temperature" | awk '{print $3}')"
    elif [ "${HOSTNAME}" == "dell01" ] || [ "${HOSTNAME}" == "dell02" ] || \
         [ "${HOSTNAME}" == "dell03" ] || [ "${HOSTNAME}" == "dell04" ] || \
         [ "${HOSTNAME}" == "smaug" ]; then
      CPUTEMP=", $(sensors | grep "CPU" | awk '{print $2}')"
    fi
  elif [ "${USER}" == "di75faw" ]; then
    if [ "${HOSTNAME}" == "badwlrz-cl01399" ]; then
      CPUTEMP=", $(sensors | grep "Package id 0:" | awk '{print $4}')"
    fi
  fi
  CPU="${CPUUTIL}${CPUTEMP}"
}

function promptGPU() {
  GPU="---"
  if [ -x "$(command -v nvidia-smi)" ]; then
    if [ "${HOSTNAME}" == "max" ] || [ "${HOSTNAME}" == "einstein" ]; then
      GPUUTI="$(nvidia-smi --query-gpu="utilization.gpu" --format="csv,noheader" | awk '{print $1 "%"}')"
      GPUTMP="$(nvidia-smi --query-gpu="temperature.gpu" --format="csv,noheader")°C"
      GPUDRIVER="$(nvidia-smi -q | grep "Driver Version" | awk '{print $4}')"
      GPU="${GPUUTI}, ${GPUTMP} (${GPUDRIVER})"
    else
      echo "ADD THE HOSTNAME FOR THIS MACHINE IN ~/.bashrc"
    fi
  fi
}

function promptBAT() {
  BAT="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | awk '{print $2}')"
}

function fetchgit() {
  # If we are in a git repository fetch in the background
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
    # If there is no instance of git fetch running
    if [ "$(pgrep -a git | grep 'git fetch')" == "" ]; then
      # () runs the command in a subshell to avoid the Done message due to the running in background
      (git fetch &)
    fi
  fi
}

function init() {
  promptRAM
  promptCPU
  promptGPU
  if [ ${EUID} != 0 ]; then
    fetchgit
  fi
}

function initlaptop() {
  promptRAM
  promptCPU
  promptGPU
  promptBAT
  if [ ${EUID} != 0 ]; then
    fetchgit
  fi
}

###########
# ALIASES #
###########
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cp='cp -iv'                        # confirm before overwriting something and copy verbose
alias mv='mv -iv'                        # confirm before overwriting something and move verbose
alias rm='rm -Iv'                        # confirm before removin more than three items and remove verbose
alias mkdir='mkdir -v'                   # create directories verbose
alias rmdir='rmdir -v'                   # delete directories verbose
alias TOP='top -u $(whoami)'             # only show user processes
alias HTOP='htop -u $(whoami)'           # only show user processes

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f "${1}" ] ; then
    case "${1}" in
      *.tar.bz2) tar xjf "${1}" ;;
      *.tar.gz)  tar xzf "${1}" ;;
      *.bz2)     bunzip2 "${1}" ;;
      *.rar)     unrar x "${1}" ;;
      *.gz)      gunzip "${1}" ;;
      *.tar)     tar xf "${1}" ;;
      *.tbz2)    tar xjf "${1}" ;;
      *.tgz)     tar xzf "${1}" ;;
      *.zip)     unzip "${1}" ;;
      *.Z)       uncompress "${1}" ;;
      *.7z)      7z x "${1}" ;;
      *)         echo "${1} cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}

########
# MISC #
########

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -f "${HOME}/.localstuff" ]; then
  source "${HOME}/.localstuff"
fi
