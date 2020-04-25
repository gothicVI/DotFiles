#
# ~/.bashrc
#

[[ $- != *i* ]] && return

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

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
        PROMPT_COMMAND=initlaptop
        PS1='\[\033[01;31m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \h\[\033[01;36m\] \W\[\033[01;31m\]$(__git_ps1 " (%s)")]\n\$\[\033[00m\] '
	else
        PROMPT_COMMAND=initlaptop
        PS1='\[\033[01;32m\][RAM free: ${RAM} | CPU: ${CPU} | GPU: ${GPU} | Battery: ${BAT} | \u@\h\[\033[01;37m\] \W\[\033[01;32m\]$(__git_ps1 " (%s)")]\n\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
        PS1='\u@\h \W \$ '
	else
        PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp='/usr/bin/cp -i'                          # confirm before overwriting something
alias df='/usr/bin/df -h'                          # human-readable sizes
alias free='/usr/bin/free -m'                      # show sizes in MB
alias np='/usr/bin/nano -w PKGBUILD'
alias more='/usr/bin/less'

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f "${1}" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "${1}"   ;;
      *.tar.gz)    tar xzf "${1}"   ;;
      *.bz2)       bunzip2 "${1}"   ;;
      *.rar)       unrar x "${1}"     ;;
      *.gz)        gunzip "${1}"    ;;
      *.tar)       tar xf "${1}"    ;;
      *.tbz2)      tar xjf "${1}"   ;;
      *.tgz)       tar xzf "${1}"   ;;
      *.zip)       unzip "${1}"     ;;
      *.Z)         uncompress "${1}";;
      *.7z)        7z x "${1}"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function promptRAM()
{
  RAM="$(free -h | awk 'NR==2 {print $4 "/" $2}')"
}

function promptCPU()
{
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.1
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  CPUUTIL="$((100 * ((total-prevtotal) - (idle-previdle)) / (total-prevtotal)))%"
  CPUTEMP=""
  if [ "${HOSTNAME}" == "mykonos" ]; then
    CPUTEMP=", $(sensors | grep "CPU Temperature" | awk '{print $3}')"
  elif [ "${HOSTNAME}" == "dell01" ] || [ "${HOSTNAME}" == "dell02" ] || \
       [ "${HOSTNAME}" == "dell03" ] || [ "${HOSTNAME}" == "dell04" ] || \
       [ "${HOSTNAME}" == "smaug" ]; then
    CPUTEMP=", $(sensors | grep "CPU" | awk '{print $2}')"
  elif [ "${HOSTNAME}" == "max" ] || [ "${HOSTNAME}" == "EINSTEIN" ]; then
    CPUTEMP=", $(sensors | grep "Package id 0:" | awk '{print $4}')"
  elif [ "${HOSTNAME}" == "kleineinstein" ]; then
    CPUTEMP=", $(sensors | grep "Core 2" | awk '{print $3}')"
  fi
  CPU="${CPUUTIL}${CPUTEMP}"
}

function promptBAT()
{
  BAT="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | awk '{print $2}')"
}

function promptGPU()
{
  GPU="---"
  if [ "${HOSTNAME}" == "max" ] || [ "${HOSTNAME}" == "EINSTEIN" ]; then
    GPUUTI="$(nvidia-smi --query-gpu="utilization.gpu" --format="csv,noheader" | awk '{print $1 "%"}')"
    GPUTMP="$(nvidia-smi --query-gpu="temperature.gpu" --format="csv,noheader")°C"
    GPU="${GPUUTI}, ${GPUTMP}"
  fi
}

function init()
{
  promptRAM
  promptCPU
  promptGPU
}

function initlaptop()
{
  promptRAM
  promptCPU
  promptBAT
  promptGPU
}

# No duplicates in .bash_history
export HISTCONTROL=ignoredups:erasedups

# This should realize an infinite history
export HISTFILESIZE=
export HISTSIZE=

# Append a session's history on shell exit
shopt -s histappend
