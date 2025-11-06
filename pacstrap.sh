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

#Install the base system
pacstrap /mnt base linux linux-firmware linux-atm linux-headers systemd --noconfirm
pacstrap /mnt nano git linux-lts linux-lts-headers reflector --noconfirm
pacstrap /mnt base-devel --noconfirm 


