#!/usr/bin/env bash
# Install script yay
# autor: Alex Creio https://cvc.hashbase.io/

sudo pacman -S --noconfirm --needed wget curl git 
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
# makepkg -si
makepkg -si --skipinteg
cd ..
rm -rf yay-bin
