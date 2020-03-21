#!/bin/bash

alias cp='/bin/cp -v'
alias mv='/bin/mv -v'
alias rm='/bin/rm -v'
alias mkdir='/bin/mkdir -v'
alias rmdir='/bin/rmdir -v'

alias HTOP='htop -u $(whoami)'
alias TOP='top -u $(whoami)'

if [ -f ~/TLMGR.sh ]; then
  alias TLMGR='~/TLMGR.sh'
fi

if [ -f ~/git/AndroidDevelopment/laos_build.sh ] && [ -d ~/android ]; then
  for rev in 14.1 15.1 16.0 17.1; do
    for dev in potter sargo thea; do
      if [ -f ~/android/laos_${rev}/.repo/local_manifests/${dev}_${rev}.xml ]; then
        alias "${dev}${rev}"="~/git/AndroidDevelopment/laos_build.sh ${dev} ${rev} $(($(nproc --all) - 2))"
      fi
    done
    if [ -d ~/android/laos_${rev} ]; then
      alias "androidclean${rev}"="rm -rfv ~/android/laos_${rev}/out/* ~/android/laos_${rev}/out/.*"
    fi
  done
fi

if [ -f ~/mvv.sh ]; then
  alias mvv='~/mvv.sh'
fi

if [ -f ~/mensa.sh ]; then
  alias mensa='~/mensa.sh'
fi

if [ -f ~/.IsLaptop ]; then
  alias BATTERY='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:'
fi
