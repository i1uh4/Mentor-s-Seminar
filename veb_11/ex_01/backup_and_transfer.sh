
#!/bin/bash
# backup_and_transfer.sh

# Конфигурация
SOURCE_DIR="/path/to/backup"
BACKUP_DIR="/tmp/backups"
REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
REMOTE_DIR="/remote/backups"
MAX_BACKUPS=3

# Создание директории для бэкапов
mkdir -p "$BACKUP_DIR"

# Имя архива с датой
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Создание архива
echo "Создание архива $BACKUP_NAME..."
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    echo "Архив успешно создан"
    
    # Копирование на удалённый сервер
    echo "Копирование на удалённый сервер..."
    scp "$BACKUP_PATH" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
    
    if [ $? -eq 0 ]; then
        echo "Архив успешно скопирован"
        
        # Удаление старых архивов на удалённом сервере
        echo "Удаление старых архивов (оставляем последние $MAX_BACKUPS)..."
        ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && ls -t backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm"
        
        echo "Резервное копирование завершено"
    else
        echo "Ошибка при копировании архива"
        exit 1
    fi
else
    echo "Ошибка при создании архива"
    exit 1
fi
