#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "archbtw" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archbtw.localdomain archbtw" >> /etc/hosts
echo root:password | chpasswd

# base packages
pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant \
          mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils \
          bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh \ 
          rsync reflector acpi acpi_call tlp virt-manager edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat \
          iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font \
          qemu-desktop qemu-emulators-full 

# graphics and touchpad drivers
pacman -S --noconfirm xf86-video-intel xf86-input-libinput

# GUI applications
pacman -S --noconfirm firefox libreoffice yad alacritty yakuake konsole retroarch libretro zathura zathura-djvu zathura-pdf-poppler sxiv pcmanfm nitrogen feh obs-studio

# stuff made in rust :)
pacman -S --noconfirm fd bat exa fzf

# terminal stuff
pacman -S --noconfirm asciinema neofetch cmus newsboat

# fonts
pacman -S --noconfirm ttf-fira-code ttf-roboto-mono

# other stuff
pacman -S --noconfirm rofi rofi-calc xmobar

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB 

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp 
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m rachit
echo rachit:rcht | chpasswd
usermod -aG libvirt rachit

echo "rachit ALL=(ALL) ALL" >> /etc/sudoers.d/rachit

clear
printf "\e[1;32mNote to self: Make sure to install rofi-bluetooth and the rest of your stuff later.\e[0m\n"
