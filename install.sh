#!/bin/sh

echo "======================================================================="
echo "=== Updateing dotilfes"
echo "==="
echo "=== $0"
echo "=== PWD  = $PWD"
echo "=== HOME = $HOME"
echo "==="
echo "======================================================================="

rm -rf $HOME/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
git -C $HOME/.oh-my-zsh checkout master
