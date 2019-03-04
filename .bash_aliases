#!/bin/bash

alias cp='/bin/cp -v'
alias mv='/bin/mv -v'
alias rm='/bin/rm -v'
alias mkdir='/bin/mkdir -v'
alias rmdir='/bin/rmdir -v'

alias HTOP='htop -u $(whoami)'
alias TOP='top -u $(whoami)'

alias TLMGR='~/TLMGR.sh'

if [ -f ~/laos_build.sh ]; then
  alias potter14.1='~/laos_build.sh potter 14.1'
  alias potter15.1='~/laos_build.sh potter 15.1'
  alias potter16.0='~/laos_build.sh potter 16.0'
  alias thea14.1='~/laos_build.sh thea 14.1'
  alias thea15.1='~/laos_build.sh thea 15.1'
  alias thea16.0='~/laos_build.sh thea 16.0'
fi

if [ -f ~/.IsLaptop ]; then
  alias BATTERY='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:'
fi
