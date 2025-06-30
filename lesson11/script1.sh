#!/bin/bash

# Константы
FOLDER_PATH="$HOME/myfolder"
FILE1_PATH="$FOLDER_PATH/file1.txt"
FILE2_PATH="$FOLDER_PATH/file2.txt"
FILE3_PATH="$FOLDER_PATH/file3.txt"
FILE4_PATH="$FOLDER_PATH/file4.txt"
FILE5_PATH="$FOLDER_PATH/file5.txt"

# Создаем папку, если ее нет
create_folder() {
    mkdir -p "$FOLDER_PATH" || {
        echo "Не удалось создать папку $FOLDER_PATH" >&2
        return 1
    }
}

# Создаем файл с приветствием и датой
create_file1() {
    echo -e "Hello, user!\n$(date)" > "$FILE1_PATH" || {
        echo "Не удалось создать $FILE1_PATH" >&2
        return 1
    }
}

# Создаем файл с правами 777
create_file2() {
    touch "$FILE2_PATH" && chmod 777 "$FILE2_PATH" || {
        echo "Не удалось создать $FILE2_PATH" >&2
        return 1
    }
}

# Создаем файл со случайной строкой
create_file3() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1 > "$FILE3_PATH" || {
        echo "Не удалось создать $FILE3_PATH" >&2
        return 1
    }
}

# Создаем пустые файлы
create_empty_files() {
    touch "$FILE4_PATH" "$FILE5_PATH" || {
        echo "Не удалось создать пустые файлы" >&2
        return 1
    }
}

main() {
    create_folder
    create_file1
    create_file2
    create_file3
    create_empty_files
}

main