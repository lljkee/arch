#!/bin/bash
#https://git.io/vbxtest.sh
read -p "Введите имя пользователя: " username
echo 'Добавляем пользователя'
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $username
echo 'Устанавливаем пароль пользователя'
passwd $username
echo 'Ставим обои темы и иконки'
  echo 'Ставим обои'
  wget -P /home/lljk/downloads/ https://git.io/dimwalp.jpg
  wget -P /home/lljk/downloads/ https://git.io/dimwalp1.jpg
  sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
  sudo mv -f /home/lljk/downloads/dimwalp.jpg /usr/share/backgrounds/xfce/dimwalp.jpg
  sudo mv -f /home/lljk/downloads/dimwalp1.jpg /usr/share/backgrounds/xfce/dimwalp1.jpg
  
  echo 'Ставим настройки'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/dimxfce4.tar.gz
  sudo rm -rf /home/lljk/.config/xfce4/panel/
  sudo rm -rf /home/lljk/.config/xfce4/*
  sudo tar -xzf /home/lljk/downloads/dimxfce4.tar.gz -C /home/lljk/  
  
  echo 'Ставим иконки'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/iconsxfce4.tar.gz
  sudo tar -xzf /home/lljk/downloads/iconsxfce4.tar.gz -C /home/lljk/
  
  echo 'Ставим темы'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/themesxfce4.tar.gz
  sudo tar -xzf /home/lljk/downloads/themesxfce4.tar.gz -C /home/lljk/
  
  echo 'Ставим conky'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/conky.tar.gz
  sudo tar -xzf /home/lljk/downloads/conky.tar.gz -C /home/lljk/.config/
  wget -P /home/lljk/downloads/ https://git.io/conky.service
  sudo mv -f /home/lljk/downloads/conky.service /etc/systemd/system/conky.service
  sudo systemctl enable conky.service
  
  echo 'Добавляем иконки'
  gtk-update-icon-cache /home/lljk/.icons/nouveGnomeGray/
  gtk-update-icon-cache /home/lljk/.icons/vamox-argentum/
  
  echo 'Настраиваем вид bash'
  rm /home/lljk/.bashrc
  wget -P /home/lljk/ https://raw.githubusercontent.com/lljkee/arch/master/attach/.bashrc
  
echo 'Установка AUR (yay)'
   wget -P /home/lljk/downloads/ git.io/yay-install.sh 
   sh /home/lljk/downloads/yay-install.sh --noconfirm

echo 'Установить Bluetooth?'
read -p "1 - Да, 0 - Нет: " btprog_set
if [[ $btprog_set == 1 ]]; then
  sudo pacman -S bluez blueman bluez-utils bluez-hid2hci pulseaudio-bluetooth --noconfirm
  sudo systemctl enable bluetooth.service --noconfirm
  yay -S bluez-hciconfig bluez-hcitool
  wget -P /home/lljk/downloads/ https://git.io/brcm.tar.gz
  sudo tar -xzf /home/lljk/downloads/brcm.tar.gz -C /lib/firmware/brcm/
elif [[ $btprog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo 'Установка автозапуска'
rm /home/lljk/.xinitrc
wget -P /home/lljk/ https://git.io/.xinitrc

rm /home/lljk/.bash_profile
wget -P /home/lljk/ https://git.io/.bash_profile

sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo wget -P /etc/systemd/system/getty@tty1.service.d/ https://git.io/override.conf

echo 'Установка завершена! Перезагрузите систему.'
exit
