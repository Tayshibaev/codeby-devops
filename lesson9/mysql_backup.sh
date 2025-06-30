#!/bin/bash

# Директория для бэкапов
BACKUP_DIR="/opt/mysql_backup"
mkdir -p "$BACKUP_DIR"

# Имя бэкапа (текущая дата и время)
BACKUP_NAME="mysql_$(date +'%Y-%m-%d_%H-%M-%S').sql"

# Дамп всех баз
sudo mysqldump --all-databases > "$BACKUP_DIR/$BACKUP_NAME"

# Архивирование (опционально)
gzip "$BACKUP_DIR/$BACKUP_NAME"

# Удаление старых бэкапов (оставляем последние 24)
find "$BACKUP_DIR" -type f -name "mysql_*.sql.gz" -mtime +1 -delete

echo "Backup created: $BACKUP_DIR/$BACKUP_NAME.gz"