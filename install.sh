#!/bin/sh
# why ln -s? ln: failed to create symbolic link ‘/home/$USER/.zshrc’
# I'm an idiot who makes too many mistakes...and yes I've accidentally nuked things by using cp.
ln -s ~/.bastion/.zshrc ~/.zshrc
touch ~/.zcustom
ln -s ~/.bastion/.zlogout ~/.zlogout
ln -s ~/.bastion/.vimrc ~/.vimrc
ln -s ~/.bastion/.vim ~/.vim # this will make nested .vim directories for extra hilarity.
