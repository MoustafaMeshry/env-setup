mkdir -p ~/usr/local
myOwnRoot=`readlink -f ~/usr/local`
echo -e "\n# Add your virtual root paths
export PATH=$myOwnRoot/bin:\$PATH
export CPATH=$myOwnRoot/include:\$CPATH
export LIBRARY_PATH=$myOwnRoot/lib:\$LIBRARY_PATH
export LD_LIBRARY_PATH=$myOwnRoot/lib:\$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$myOwnRoot/lib/pkgconfig:\$PKG_CONFIG_PATH\n" >> ~/.bashrc
