#!/bin/bash

#-------------------------------------------------------------------------------
# Script         : Install tmux, without root access
# Original script: https://gist.github.com/ryin/3106801
# Modified by    : Moustafa Meshry
# Date           : May 31, 2017
# It's assumed that wget and a C/C++ compiler are installed.
# It's assumed that setUpVirtualRoot.sh has been run as well
#-------------------------------------------------------------------------------

# exit on error
set -e

TMUX_VERSION=2.5

# create our directories
mkdir -p $HOME/usr/local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# Install libevent, if not already there
if ! ldconfig -p | grep libevent > /dev/null; then
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
    echo "Installig libevent..."
    tar xvzf libevent-2.0.19-stable.tar.gz
    cd libevent-2.0.19-stable
    ./configure --prefix=$HOME/usr/local --disable-shared
    make
    make install
    cd ..
fi

# Install libncurses, if not already there
if ! ldconfig -p | grep libncurses > /dev/null; then
    wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
    echo "Installing libncurses..."
    tar xvzf ncurses-5.9.tar.gz
    cd ncurses-5.9
    ./configure --prefix=$HOME/usr/local
    make
    make install
    cd ..
fi

# Install tmux if not already there
if ! which tmux > /dev/null 2> /dev/null; then
    wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
    tar xvzf tmux-${TMUX_VERSION}.tar.gz
    cd tmux-${TMUX_VERSION}
    ./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
    cp tmux $HOME/local/bin
    cd ..
fi

# cleanup
rm -rf $HOME/tmux_tmp

# add $HOME/usr/local/bin to $PATH
#if ! which tmux > /dev/null 2> /dev/null; then
#    echo -e "\n# add \$HOME/usr/local/bin to \$PATH\nexport PATH=\"$HOME/usr/local/bin:\$PATH\"\n" >> ~/.bashrc
#fi
