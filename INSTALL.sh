#!/bin/bash

thisscript=${PWD}/INSTALL.sh
cd "${HOME}" || exit
echo " ====================================================================== "
echo " === Downloading DotFiles from https://github.com/gothicVI/DotFiles === "
echo " ===                   This is done interactively                   === "
echo " ===                  Make sure to have a backup!                   === "
echo " ====================================================================== "
echo ""
echo "Downloading .bash_aliases, .bash_logout, .bashrc, .checkifsourced, .cmdpromt, .profile, .vimrc"
echo "Hit ENTER to continue or Ctrl+C to abort"
echo ""
read -s
for file in .bash_aliases .bash_logout .bashrc .checkifsourced .cmdpromt .profile .vimrc; do
  if [ -f "${file}" ]; then
    rm ${file}
    wget "https://raw.githubusercontent.com/gothicVI/DotFiles/master/${file}"
  fi
done
echo ""
while true; do
        read -p "Is this a laptop? Type Y/y or N/n and hit ENTER: " laptop
        case $laptop in
                [Yy]* ) echo "";
                  if [ -f .IsLaptop ]; then
                    rm .IsLaptop
                  fi;
                  wget https://raw.githubusercontent.com/gothicVI/DotFiles/master/.IsLaptop;
                  break;;
                [Nn]* ) echo ""; break;;
        esac
done
echo ""
while true; do
        echo "Do you compile Android and want to use ccache and limit the RAM consumption for jack?"
        read -p " Type 4 for a 4GM limit, or 8 for a 8GB limit, or 16 for a 16GB limit or N/n and hit ENTER: " android
        case $android in
                [4]* )  echo "";
                    if [ -f .Android ]; then
                    rm .Android
                    fi;
                    echo 'export USE_CCACHE=1' >> .Android;
                    echo 'export CCACHE_COMPRESS=1' >> .Android;
                    echo 'export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"' >> .Android;
                    echo 'export JAVA_TOOL_OPTIONS=-Xmx4G' >> .Android
                    break;;
                [8]* ) echo "";
                    if [ -f .Android ]; then
                    rm .Android
                    fi;
                    echo 'export USE_CCACHE=1' >> .Android;
                    echo 'export CCACHE_COMPRESS=1' >> .Android;
                    echo 'export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx8G"' >> .Android;
                    echo 'export JAVA_TOOL_OPTIONS=-Xmx8G' >> .Android
                    break;;
                [16]* ) echo "";
                    if [ -f .Android ]; then
                    rm .Android
                    fi;
                    echo 'export USE_CCACHE=1' >> .Android;
                    echo 'export CCACHE_COMPRESS=1' >> .Android;
                    echo 'export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx16G"' >> .Android;
                    echo 'export JAVA_TOOL_OPTIONS=-Xmx16G' >> .Android
                    break;;
                [Nn]* ) echo ""; break;;
        esac
done
echo ""
echo " === We're done! Deleting this installation script now: === "
rm -v "${thisscript}"
exit
