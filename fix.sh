#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y or N.";;
        esac
    done
}
example-function() {
    echo "$2"
}

pacman -Sy linux linux-headers
pacman -S linux-lts linux-lts-headers
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

confirm "Did it work?"

confirm "type exit and reboot"
