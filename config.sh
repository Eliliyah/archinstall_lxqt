#!/usr/bin/bash

#FUNCTIONS GO HERE

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

#set time
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status
locale-gen
confirm "Did the time set correctly?"

#install system services
pacman -S --needed networkmanager --noconfirm
systemctl enable networkmanager
confirm "Did networkmanager install?"

pacman -S --needed lm_sensors --noconfirm
systemctl enable lm_sensors
confirm "Did lmsensors install?"

pacman -S --needed acpid --noconfirm
systemctl enable acpid
confirm "Did acpid install?"

pacman -S --needed power-profiles-daemon --noconfirm
systemctl enable power-profiles-daemon
confirm "Did power-profiles-daemon install?"

pacman -S --needed bluez bluez-utils pulseaudio-bluetooth blueman --noconfirm
systemctl enable bluetooth
confirm "Did bluetooth install?"

pacman -S --needed preload --noconfirm
systemctl enable preload
confirm "Did preload install?"

pacman -S --needed upower --noconfirm
systemctl enable upower
confirm "Did upower install?"

pacman -S --needed sddm --noconfirm
systemctl enable sddm
confirm "Did sddm install?"

#install aura
pacman -S aura
confirm "Did aura install?"

#Configure sddm
aura -A archlinux-themes-sddm --noconfirm
echo "[Theme]
Current=archlinux-simplyblack">> /etc/sddm.conf
nano /etc/sddm.conf
confirm "All good?"

for pkg in konsole xterm fish vivaldi iwd element-desktop discord aura starship vscodium btop dolphin strawberry libreoffice-fresh ttf-daddytime-mono-nerd kde-style-oxygen-qt6; do
  pacman -S --needed --noconfirm "$pkg"
done

#Configure journal
echo "Storage=persistent" >> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Enable Network Configuration
echo "[General]
EnableNetworkConfiguration=true" >> /etc/iwd/main.conf

#Configure zram
pacman -S zram-generator --noconfirm
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

#Configure initramfs for intel
sed -i '7,52 s/^/#/' /etc/mkinitcpio.conf
echo "
COMPRESSION="zstd"
MODULES=(crc32c)
BINARIES=()
FILES=()
HOOKS=(base udev autodetect microcode kms modconf block keyboard keymap consolefont resume plymouth filesystems) " >> /etc/mkinitcpio.conf

#Generate the initramfs
mkinitcpio -p linux
mkinitcpio -p linux-lts
confirm "Did the initramfs generate successfully?"
