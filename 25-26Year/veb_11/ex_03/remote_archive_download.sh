#!/bin/bash
# remote_archive_download.sh

REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
REMOTE_DIR="/path/to/remote/directory"
LOCAL_DOWNLOAD_DIR="./downloads"
LOCAL_EXTRACT_DIR="./extracted"

# Создание локальных директорий
mkdir -p "$LOCAL_DOWNLOAD_DIR"
mkdir -p "$LOCAL_EXTRACT_DIR"

ARCHIVE_NAME="remote_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
REMOTE_ARCHIVE="/tmp/$ARCHIVE_NAME"

echo "Архивирование удалённой директории..."
ssh "$REMOTE_USER@$REMOTE_HOST" "tar -czf $REMOTE_ARCHIVE -C $(dirname $REMOTE_DIR) $(basename $REMOTE_DIR)"
f [ $? -eq 0 ]; then
    echo "Скачивание архива..."
    scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_ARCHIVE" "$LOCAL_DOWNLOAD_DIR/"
    
    if [ $? -eq 0 ]; then
        echo "Разархивирование..."
        tar -xzf "$LOCAL_DOWNLOAD_DIR/$ARCHIVE_NAME" -C "$LOCAL_EXTRACT_DIR"
        
        echo "Удаление временного архива с удалённого сервера..."
        ssh "$REMOTE_USER@$REMOTE_HOST" "rm $REMOTE_ARCHIVE"
        
        echo "Операция завершена успешно"
        echo "Файлы извлечены в: $LOCAL_EXTRACT_DIR"
    else
        echo "Ошибка при скачивании архива"
        exit 1
    fi
else
    echo "Ошибка при создании архива"
    exit 1
fi
