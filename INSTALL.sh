#!/bin/bash

thisscript=${PWD}/INSTALL.sh
cd "${HOME}" || exit
echo " === Downloading DotFiles from https://github.com/gothicVI/DotFiles === "
echo " === This is done interactively === "
echo " === Make sure to have a backup! === "
echo ""
echo "Downloading .bash_aliases, .bash_logout, .bashrc, .checkifsourced, .cmdpromt, .profile"
echo "Hit ENTER to continue or Ctrl+C to abort"
echo ""
read -s
for file in .bash_aliases .bash_logout .bashrc .checkifsourced .cmdpromt .profile; do
  if [ -f "${file}" ]; then
    rm ${file}
  fi
done
wget https://raw.githubusercontent.com/gothicVI/DotFiles/master/.bash_aliases https://raw.githubusercontent.com/gothicVI/DotFiles/master/.bash_logout https://raw.githubusercontent.com/gothicVI/DotFiles/master/.bashrc https://raw.githubusercontent.com/gothicVI/DotFiles/master/.checkifsourced https://raw.githubusercontent.com/gothicVI/DotFiles/master/.cmdpromt https://raw.githubusercontent.com/gothicVI/DotFiles/master/.profile
echo ""
while true; do
        read -p "Is this a laptop? Type Y/y or N/n and hit ENTER: " laptop
        case $laptop in
                [Yy]* ) echo ""; wget https://raw.githubusercontent.com/gothicVI/DotFiles/master/.IsLaptop; break;;
                [Nn]* ) echo ""; break;;
        esac
done
echo ""
while true; do
        echo "Do you compile Android and want to use ccache and limit the RAM consumption for jack?"
        read -p " Type 5 for a 5GM limit or 20 for a 20GB limit or N/n and hit ENTER: " android
        case $android in
                [5]* ) echo ""; wget https://raw.githubusercontent.com/gothicVI/DotFiles/master/.android5G; break;;
                [20]* ) echo ""; wget https://raw.githubusercontent.com/gothicVI/DotFiles/master/.android20G; break;;
                [Nn]* ) echo ""; break;;
        esac
done
echo ""
echo " === We're done! Deleting this installation script now: === "
rm -v "${thisscript}"
exit
