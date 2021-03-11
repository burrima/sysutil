#!/bin/bash

olddir=`pwd`
homedir=~

if [ ! -e "vimrc" ]; then
  echo "ERROR: You must be inside sysutil git path" > /dev/stderr
  exit 1
fi

# Install vim package manager initially (update via :PackUpdate):
echo "Installing vim package manager..."
minpacdir="$homedir/.vim/pack/minpac/opt"
if [ -e "$minpacdir" ]; then
    echo "minpac is already installed"
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
          echo "Copying vimrc-user to ~/.vimrc..."
          cp "vimrc-user" "$homedir/.vimrc"
          break;;
      [Nn]* )
          echo "Please manually source the file vimrc into your own ./vimrc"
          echo "and run :PackUpdate after re-strting vim."
          exit
          break;;
      * ) echo "Please answer Y or N.";;
    esac
  done
else
  echo "No ~/.vimrc detected in your home drive, installing template"
  cp "vimrc-user" "$homedir/.vimrc"
fi

# Install/Update plugins:
echo ""
echo "Vim will now open and install/update its plugins."
echo "Please wait until it is finished and then quit Vim manually."
echo "Note: please ignore messages about missing plugins when vim starts..."
echo "Press <Enter> to continue:"
read
vim -c PackUpdate  # exit vim when done

echo "Installation done."
