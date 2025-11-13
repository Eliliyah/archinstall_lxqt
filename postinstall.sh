#!/usr/bin/bash

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

#Install aur helper
for pkg in aura; do
  pacman -S --needed --noconfirm "$pkg"
done
confirm "All good?" 

#Install AUR packages
for pkg in hunspell-en-med-glut-git debtap masterpdfeditor-free appimagelauncher hunspell-en-med-glut-git libreoffice-extension-cleandoc ocs-url onevpl-intel-gpu pacdiff-pacman-hook-git wd719x-firmware aic94xx-firmware; do
  aura -A --noconfirm "$pkg"
done
