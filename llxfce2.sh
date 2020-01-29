#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

echo 'Добавляем пользователя'
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $username

echo 'Создаем root пароль'
passwd

echo 'Устанавливаем пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo 'lljk ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Куда устанавливем Arch Linux на виртуальную машину?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit xorg-apps mesa-libgl xterm"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
fi

echo 'Ставим иксы и драйвера'
pacman -S $gui_install
pacman -S xfce4 xfce4-goodies --noconfirm
#echo "Какое DE ставим?"
#read -p "1 - XFCE, 2 - KDE, 3 - Openbox: " vm_setting
#if [[ $vm_setting == 1 ]]; then
 # pacman -S xfce4 xfce4-goodies --noconfirm
#elif [[ $vm_setting == 2 ]]; then
 # pacman -Sy plasma-meta kdebase --noconfirm
#elif [[ $vm_setting == 3 ]]; then  
#  pacman -S  openbox xfce4-terminal
#fi

#echo 'Cтавим DM'
#pacman -S slim --noconfirm
#systemctl enable slim

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-ukai ttf-arphic-uming ttf-hanazono --noconfirm 

#echo 'Ставим сеть'
#pacman -S networkmanager network-manager-applet modemmanager ppp --noconfirm

#echo 'Подключаем автозагрузку менеджера входа и интернет'
#systemctl enable NetworkManager

echo 'Установка AUR (yay)'
wget -P /home/lljk/ git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установить звук?'
read -p "1 - Да, 0 - Нет: " soundprog_set
if [[ $soundprog_set == 1 ]]; then
  sudo pacman -S alsa-lib alsa-utils pulseaudio pulseaudio-alsa pavucontrol --noconfirm
elif [[ $soundprog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo 'Установка программ'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
 sudo pacman -S chromium vlc screenfetch bash-completion qbittorrent ntfs-3g p7zip unrar gvfs --noconfirm
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi


echo 'Установка доп программ'
read -p "1 - Да, 0 - Нет: " dopprog_set
if [[ $dopprog_set == 1 ]]; then
sudo pacman -S f2fs-tools conky htop modemmanager ppp hddtemp gawk net-tools galculator dosfstools --noconfirm
elif [[ $dopprog_set == 0 ]]; then
  echo 'Установка доп программ пропущена.'
fi

echo 'Установка автозапуска'
rm /home/lljk/.xinitrc
wget -P /home/lljk/ https://git.io/.xinitrc

rm /home/lljk/.bash_profile
wget -P /home/lljk/ https://git.io/.bash_profile

sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo wget -P /etc/systemd/system/getty@tty1.service.d/ https://git.io/override.conf

echo 'Установка завершена! Перезагрузите систему.'
#echo 'Если хотите подключить AUR, установить мои конфиги XFCE, тогда после перезагрзки и входа в систему, установите wget (sudo pacman -S wget) и выполните команду:'
#echo 'wget https://raw.githubusercontent.com/lljkee/arch/master/lljk3.sh && sh lljk3.sh'

exit
