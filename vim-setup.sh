#!/bin/bash

olddir=`pwd`
homedir=~

if [ ! -e "vimrc-base" ]; then
  echo "ERROR: You must be inside sysutil git path" > /dev/stderr
  exit 1
fi

# Install vim package manager initially (update via :PackUpdate):
echo "Installing vim package manager..."
minpacdir="$homedir/.vim/pack/minpac/opt"
if [ -e "$minpacdir" ]; then
    echo "minpac is already installed, updating..."
    cd "$minpacdir"/minpac
    git pull
    cd "$olddir"
else
    echo "minpac is not installed, installing now..."
    mkdir -p "$minpacdir"
    cd "$minpacdir"
    git clone https://github.com/k-takata/minpac.git
    cd "$olddir"
fi

if [ -e "$homedir/.vimrc" ]; then
  echo "~/.vimrc detected in your home drive!"
  while true; do
    read -r -p "Do you wish to replace your ~/.vimrc? (Y/N): " answer
    case $answer in
      [Yy]* )
          echo "Creating ~/.vimrc.backup..."
          mv "$homedir/.vimrc" "$homedir/.vimrc.backup"
          echo "Linking vimrc-base to ~/.vimrc..."
          ln -s sysutil/vimrc-base "$homedir/.vimrc"
          break;;
      [Nn]* )
          echo "Please manually source the file vimrc-base into your own ./vimrc"
          echo "and run :PackUpdate after re-strting vim."
          exit
          break;;
      * ) echo "Please answer Y or N.";;
    esac
  done
else
  echo "No ~/.vimrc detected in your home drive, installing default"
    echo "Linking vimrc-base to ~/.vimrc..."
    ln -s sysutil/vimrc-base "$homedir/.vimrc"
fi

# Install/Update plugins:
echo ""
echo "Vim will now open and install/update its plugins."
echo "Please wait until it is finished and then quit Vim manually."
echo "Note: please ignore messages about missing plugins when vim starts..."
echo "Press <Enter> to continue:"
read
vim -c PackMaintain  # exit vim when done

echo "Installation done."
