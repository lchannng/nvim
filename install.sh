#!/bin/bash -e
# File  : install.sh
# Author: lchannng <l.channng@gmail.com>
# Date  : 2022/04/02 20:17:55

function cleanup() {
    target=$1
    if [ -d ${target} ]; then rm -rf ${target}; fi
    mkdir -p ${target}
}

mkdir -p ~/.local/bin
LS_ROOT=`pwd`/language-server

cleanup ${LS_ROOT}/lua
if [[ $OSTYPE == "linux-gnu"* ]]; then
    curl -L https://github.com/sumneko/lua-language-server/releases/download/2.6.7/lua-language-server-2.6.7-linux-x64.tar.gz | tar -zvx -C ${LS_ROOT}/lua
    ln -snf ${LS_ROOT}/lua/bin/lua-language-server ~/.local/bin/lua-language-server
elif [[ $OSTYPE == "darwin"* ]]; then
    brew update
    brew install lua-language-server
else
    echo "unsupported os: $OSTYPE"
    exit -1
fi

npm install --prefix ${LS_ROOT} pyright
npm install --prefix ${LS_ROOT} bash-language-server
