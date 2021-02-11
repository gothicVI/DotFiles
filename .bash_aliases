#!/bin/bash

alias cp='/bin/cp -v'
alias mv='/bin/mv -v'
alias rm='/bin/rm -v'
alias mkdir='/bin/mkdir -v'
alias rmdir='/bin/rmdir -v'

alias HTOP='htop -u $(whoami)'
alias TOP='top -u $(whoami)'

if [ -f ~/git/Scripts/TLMGR.sh ]; then
  alias TLMGR='~/git/Scripts/TLMGR.sh'
fi

if [ -f ~/git/Scripts/mvv.sh ]; then
  alias mvv='~/mvv.sh'
fi

if [ -f ~/git/Scripts/mensa.sh ]; then
  alias mensa='~/mensa.sh'
fi

if [ -f ~/.IsLaptop ]; then
  alias BATTERY='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:'
fi
