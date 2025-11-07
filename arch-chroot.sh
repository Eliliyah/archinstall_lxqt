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

chmod +x user.sh
./user.sh
confirm "Were the locales set and user created successfully?"

pacman-key --init
pacman-key --update
pacman -Syu

chmod +x keyrings.sh
./keyrings.sh
confirm "Did the keyrings install and mirrors update successfully?"

chmod +x packages.sh
./packages.sh
confirm "Did all packages install successfully?"

chmod +x config.sh
./config.sh
confirm "Was the system configured successfully?"

chmod +x grub.sh
./grub.sh
confirm "Was the bootloader installed properly?"
