#!/bin/bash

#-------------------------------------------------------------------------------
# Script: Install htop, without root access
# Author: Moustafa Meshry
# Date  : May 31, 2017
#-------------------------------------------------------------------------------

# exit on error
set -e

HTOP_VERSION=2.0.1

# create our directories
mkdir -p $HOME/local $HOME/htop_tmp
cd $HOME/htop_tmp

# Install libncurses, if not already there
if ! ldconfig -p | grep libncurses > /dev/null; then
    echo "Installing libncurses..."
    tar xvzf ncurses-5.9.tar.gz
    cd ncurses-5.9
    ./configure --prefix=$HOME/usr/local
    make
    make install
    cd ..
fi

# Install htop if not already there
if ! which htop > /dev/null 2> /dev/null; then
    wget -O htop-${HTOP_VERSION}.tar.gz http://hisham.hm/htop/releases/${HTOP_VERSION}/htop-${HTOP_VERSION}.tar.gz
    tar xvfvz htop-${HTOP_VERSION}.tar.gz
    cd htop-${HTOP_VERSION}
    ./configure --prefix=$HOME/usr/local
    make
    make install
    cd ..
fi

# cleanup
rm -rf $HOME/htop_tmp

# add $HOME/usr/local/bin to $PATH
if ! which htop > /dev/null 2> /dev/null; then
    echo -e "\n# add \$HOME/usr/local/bin to \$PATH\nexport PATH=\"$HOME/usr/local/bin:\$PATH\"\n" >> ~/.bashrc
fi

