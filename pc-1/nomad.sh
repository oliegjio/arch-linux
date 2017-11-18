chpasswd <<< "root:asdf"

useradd -m -G wheel archie
chpasswd <<< "archie:asdf"
echo "archie ALL=(ALL) ALL" >> /etc/sudoers

echo archie > /etc/hostname

sed -i '/^#.*en_US/s/^#//' /etc/locale.gen
locale-gen

pacman -S --noconfirm grub wpa_supplicant dialog

disk="$(df . | tail -n1 | awk '{print $1}')"
disk=${disk%?}

grub-install $disk
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd

exit 
