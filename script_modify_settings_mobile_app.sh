#!/bin/bash

# Проверка наличия входного файла
if [ $# -ne 1 ]; then
    echo "Usage: $0 <user_list_file>"
    exit 1
fi

user_list_file=$1

# Проверка существования файла со списком пользователей
if [ ! -f "$user_list_file" ]; then
    echo "File $user_list_file not found!"
    exit 1
fi

# Цикл по каждому пользователю из файла
while IFS= read -r userName; do
    # Получаем userId из /etc/passwd
    userId=$(grep "^$userName:" /etc/passwd | cut -d':' -f3)

    # Проверка на существование пользователя
    if [ -z "$userId" ]; then
        echo "User $userName not found!"
        continue
    fi

    # Копирование файла magmaSettings.ini в magmaSettings_backup.ini
    cp "/home/$userName/mobile_app/settings.ini" "/home/$userName/mobile_app/settings_backup.ini"

    # Увеличиваем userId на 10000
    userIdNew=$((userId + 10000))

    # Путь к файлу конфигурации
    config_file="/home/$userName/mobile_app/settings.ini"

    # Добавление строк в файл
    echo -e "\nstartScanerSppuPort=$userIdNew" >> "$config_file"
    echo "endScanerSppuPort=$userIdNew" >> "$config_file"

    # Замена строки в файле
    sed -i 's|urlServer=https://demo.asugr.iccdev.ru/api/|urlServer=https://magma.demo.magma.iccdev.ru/|' "$config_file"

    echo "Configuration for $userName updated in $config_file"

done < "$user_list_file"
