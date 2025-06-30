#!/bin/bash

# Проверяем существование папки myfolder
if [ ! -d ~/myfolder ]; then
    echo "Папка myfolder не существует"
    exit 0
fi

# Подсчет количества файлов в папке
file_count=$(ls ~/myfolder | wc -l)
echo "Количество файлов в myfolder: $file_count"

# Исправление прав для file2.txt
if [ -f ~/myfolder/file2.txt ]; then
    chmod 664 ~/myfolder/file2.txt
fi

# Удаление пустых файлов
find ~/myfolder -maxdepth 1 -type f -empty -delete

# Удаление всех строк кроме первой в непустых файлах
for file in ~/myfolder/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        # Сохраняем первую строку во временный файл
        head -n 1 "$file" > "$file.tmp"
        # Перемещаем временный файл на место оригинального
        mv "$file.tmp" "$file"
    fi
done