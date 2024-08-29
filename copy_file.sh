#!/bin/bash

# Проверяем, передан ли файл со списком пользователей и файл для копирования
if [ $# -ne 2 ]; then
  echo "Использование: $0 <файл со списком пользователей> <файл для копирования>"
  exit 1
fi

user_list_file="$1"
file_to_copy="$2"

# Проверяем, существует ли файл для копирования
if [ ! -f "$file_to_copy" ]; then
  echo "Файл для копирования $file_to_copy не найден"
  exit 1
fi

# Проходим по каждому имени пользователя из файла
while IFS= read -r username; do
  # Проверяем, существует ли домашняя директория пользователя
  user_home_dir="/home/$username"
  if [ -d "$user_home_dir" ]; then
    # Копируем файл в домашнюю директорию пользователя
    cp "$file_to_copy" "$user_home_dir"
    echo "Файл $file_to_copy скопирован в $user_home_dir"
  else
    echo "Домашняя директория для пользователя $username не найдена"
  fi
