#!/bin/bash

# Проверяем, передан ли файл с пользователями
if [ -z "$1" ]; then
  echo "Использование: $0 <файл со списком пользователей>"
  exit 1
fi

# Проходим по каждому имени пользователя из файла
while IFS= read -r username; do
  # Проверяем, существует ли файл /home/$username/mobile_app/settings.ini
  settings_file="/home/$username/mobile_app/settings.ini"
  if [ -f "$settings_file" ]; then
    # Удаляем последние 2 строки из файла
    sed -i '$d' "$settings_file"  # Удаляем последнюю строку
    sed -i '$d' "$settings_file"  # Удаляем еще одну последнюю строку
    echo "Последние 2 строки удалены из $settings_file"
  else
    echo "Файл $settings_file не найден для пользователя $username"
  fi
done < "$1"
