export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export EDITOR=/usr/bin/vim

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="${HOME}/bin:${PATH}"
fi
if [ -d "${HOME}/git/diff-so-fancy" ]; then
    PATH="${HOME}/git/diff-so-fancy:$PATH"
fi

export USE_CCACHE=1
export CCACHE_COMPRESS=1
#export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx8G"
#export JAVA_TOOL_OPTIONS=-Xmx8G
