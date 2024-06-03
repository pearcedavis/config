#!/bin/sh

mkdir -p ~/.ssh
mkdir -p ~/.vim/after
mkdir -p ~/.vim/colors

cp bashrc ~/.bashrc
cp curlrc ~/.curlrc
cp gitconfig ~/.gitconfig
cp gitignore ~/.gitignore
cp inputrc ~/.inputrc
cp ssh/config ~/.ssh/config
cp tmux.conf ~/.tmux.conf
cp vimrc ~/.vimrc
cp -r vim/after ~/.vim
cp -r vim/colors ~/.vim
