alias cp='/bin/cp -v'
alias mv='/bin/mv -v'
alias rm='/bin/rm -v'
alias mkdir='/bin/mkdir -v'
alias rmdir='/bin/rmdir -v'

alias HTOP='htop -u $(whoami)'
alias TOP='top -u $(whoami)'

alias TLMGR='~/TLMGR.sh'

if [ -f ~/laos_build.sh ]; then
  alias thea14.1='~/thea_14.1.sh'
  alias thea15.1='~/thea_15.1.sh'
  alias potter14.1='~/potter_14.1.sh'
  alias potter15.1='~/potter_15.1.sh'
fi

if [ -f ~/.IsLaptop ]; then
  alias BATTERY='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:'
fi
