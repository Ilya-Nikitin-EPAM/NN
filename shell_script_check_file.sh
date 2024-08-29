#!/bin/bash

# Очистим файлы, если они существуют
> nothing_to_do.txt
> users.txt

# Проходим по каждому пользователю в директории /home
for userName in $(ls /home); do
    # Проверяем наличие файла
    if [ -f "/home/$userName/mobile_app/settings.ini" ]; then
        # Если файл существует, добавляем имя пользователя в users.txt
        echo "$userName" >> users.txt
    else
        # Если файл не существует, добавляем имя пользователя в nothing_to_do.txt
        echo "$userName" >> nothing_to_do.txt
    fi
done

echo "Скрипт выполнен."
