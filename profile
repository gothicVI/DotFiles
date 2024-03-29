#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Ensure /etc/profile is sourced
test -z "${PROFILEREAD}" && source /etc/profile || true

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
        source "${HOME}/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]; then
    PATH="${HOME}/bin:$PATH"
fi
if [ -d "${HOME}/.local/bin" ]; then
    PATH="${HOME}/.local/bin:$PATH"
fi

# # Together with >>AddKeysToAgent yes<< in ~/.ssh/config this only asks once for ssh passphrases
# if [ -z "$SSH_AUTH_SOCK" ]; then
#   eval $(ssh-agent -s)
# #  ssh-add
# fi
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# set diff-so-fancy path - this can not be done via a symlink
# in ~/bin because a subfolder needs to exist relative to the
# executable
if [ -d "${HOME}/git/diff-so-fancy" ]; then
    PATH="${HOME}/git/diff-so-fancy:$PATH"
fi

# exports
export EDITOR=/usr/bin/vim
# fix warpinator having issues with protobuff>3.20.x
if [ -x "$(command -v warpinator)" ]; then
  export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
fi

# Manjaro specific stuff
if [ "${HOSTNAME}" == "max" ] || [ "${HOSTNAME}" == "einstein" ] || \
   [ "${HOSTNAME}" == "kleineinstein" ]; then
  export QT_QPA_PLATFORMTHEME="qt5ct"
  export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
  if [ "${USER}" == "sebastian" ]; then
    export USE_CCACHE=1
    export CCACHE_COMPRESS=1
    #export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx8G"
    #export JAVA_TOOL_OPTIONS=-Xmx8G
  fi
fi
