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
pacman -S aura
confirm "All good?" 

#Install AUR packages
sudo aura -A pamac-all --noconfirm
sudo aura -A stacer-bin chromium-extension-plasma-integration hunspell-en-med-glut-git timeshift timeshift-autosnap --noconfirm
confirm "All good?" 
sudo aura -S pipewire-support --noconfirm
sudo aura -A pipewire-jack-dropin --noconfirm
sudo aura -A debtap masterpdfeditor-free --noconfirm
sudo aura -A appimagelauncher --noconfirm
sudo aura -A hunspell-en-med-glut-git libreoffice-extension-cleandoc libreoffice-extension-languagetool libreoffice-extension-minicorrector ocs-url nerd-fonts-complete onevpl-intel-gpu pacdiff-pacman-hook-git systemd-boot-pacman-hook wd719x-firmware aic94xx-firmware --noconfirm
