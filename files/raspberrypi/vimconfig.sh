#!/usr/bin/env bash


mkdir ~/.vim
mkdir ~/.vim/colors
curl "http://icc.one/files/raspberrypi/vim.rc" > ~/.vim/vimrc
curl "http://icc.one/files/raspberrypi/vimrc.keybindings" > ~/.vim/vimrc.keybindings
curl "http://icc.one/files/raspberrypi/solarized.vim" > ~/.vim/colors/solarized.vim

