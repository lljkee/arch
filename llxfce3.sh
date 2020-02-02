#!/bin/bash

echo 'Ставим настройки'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/dimxfce4.tar.gz
  rm -rf /home/lljk/.config/xfce4/panel/
  rm -rf /home/lljk/.config/xfce4/*
  tar -xzf /home/lljk/downloads/dimxfce4.tar.gz -C /home/lljk/.config/  
  
  echo 'Ставим иконки'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/iconsxfce4.tar.gz
  tar -xzf /home/lljk/downloads/iconsxfce4.tar.gz -C /home/lljk/
  
  echo 'Ставим темы'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/themesxfce4.tar.gz
  tar -xzf /home/lljk/downloads/themesxfce4.tar.gz -C /home/lljk/
  
  echo 'Ставим conky'
  wget -P /home/lljk/downloads/ https://github.com/lljkee/arch/raw/master/attach/conky.tar.gz
  tar -xzf /home/lljk/downloads/conky.tar.gz -C /home/lljk/.config/
  
  echo 'Добавляем иконки'
  gtk-update-icon-cache /home/lljk/.icons/nouveGnomeGray/
  gtk-update-icon-cache /home/lljk/.icons/vamox-argentum/
  
  echo 'Настраиваем вид bash'
  rm /home/lljk/.bashrc
  wget -P /home/lljk/ https://raw.githubusercontent.com/lljkee/arch/master/attach/.bashrc

  wget git.io/aurdim.sh && sh aurdim.sh
