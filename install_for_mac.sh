#!/bin/bash

cd ~/.vim_runtime/my_plugins/YouCompleteMe && git submodule update --init --recursive

bash ~/.vim_runtime/install_awesome_vimrc.sh

# format tools
sudo pip3 install yapf
brew install clang-format

cd ~/.vim_runtime/my_plugins/YouCompleteMe
python3 install.py --clang-completer
