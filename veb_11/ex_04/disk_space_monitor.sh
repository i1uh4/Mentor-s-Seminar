

### Упражнение 4: Мониторинг свободного места

```bash
#!/bin/bash
# disk_space_monitor.sh

REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
THRESHOLD=80  # Порог в процентах
EMAIL="admin@example.com"

# Функция отправки email
send_alert() {
    local usage="$1"
    local partition="$2"
    local subject="Предупреждение: Мало места на диске $REMOTE_HOST"
    local body="Раздел $partition заполнен на $usage%\nПорог: $THRESHOLD%"
    
    echo -e "$body" | mail -s "$subject" "$EMAIL"
}

echo "Проверка свободного места на $REMOTE_HOST..."

# Получение информации о дисках
DISK_INFO=$(ssh "$REMOTE_USER@$REMOTE_HOST" "df -h | grep -vE '^Filesystem|tmpfs|cdrom'")

echo "$DISK_INFO" | while read -r line; do
    USAGE=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    PARTITION=$(echo "$line" | awk '{print $6}')
    
    if [ -n "$USAGE" ] && [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "ВНИМАНИЕ: Раздел $PARTITION заполнен на $USAGE%"
        send_alert "$USAGE" "$PARTITION"
    else
        echo "OK: Раздел $PARTITION заполнен на $USAGE%"
    fi
done
