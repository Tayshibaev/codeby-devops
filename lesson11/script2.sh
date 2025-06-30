#!/bin/bash

# Константы
FOLDER_PATH="$HOME/myfolder"
FILE2_PATH="$FOLDER_PATH/file2.txt"

# Проверяем существование папки
check_folder() {
    if [ ! -d "$FOLDER_PATH" ]; then
        echo "Папка $FOLDER_PATH не существует" >&2
        return 1
    fi
    return 0
}

# Подсчет файлов в папке
count_files() {
    local count
    count=$(ls "$FOLDER_PATH" | wc -l)
    echo "Количество файлов в $FOLDER_PATH: $count"
    return 0
}

# Исправление прав для file2
fix_file2_permissions() {
    if [ -f "$FILE2_PATH" ]; then
        chmod 664 "$FILE2_PATH" || {
            echo "Не удалось изменить права для $FILE2_PATH" >&2
            return 1
        }
    fi
    return 0
}

# Удаление пустых файлов
remove_empty_files() {
    find "$FOLDER_PATH" -maxdepth 1 -type f -empty -delete || {
        echo "Ошибка при удалении пустых файлов" >&2
        return 1
    }
    return 0
}

# Удаление строк кроме первой в файлах
truncate_files() {
    local file
    for file in "$FOLDER_PATH"/*; do
        if [ -f "$file" ] && [ -s "$file" ]; then
            head -n 1 "$file" | sponge "$file" || {
                echo "Не удалось обрезать файл $file" >&2
                return 1
            }
        fi
    done
    return 0
}

main() {
    check_folder || exit 1
    count_files
    fix_file2_permissions
    remove_empty_files
    truncate_files
}

main