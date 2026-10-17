
#!/bin/bash
# sync_files.sh

LOCAL_DIR="/path/to/local/directory"
REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
REMOTE_DIR="/path/to/remote/directory"
EMAIL="admin@example.com"
LOG_FILE="/var/log/sync_$(date +%Y%m%d_%H%M%S).log"

# Исключения
EXCLUDE_PATTERNS=(
    "*.tmp"
    "*.log"
    ".git/"
    "node_modules/"
)

# Формирование параметров исключения
EXCLUDE_ARGS=""
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude=$pattern"
done

echo "Начало синхронизации..." | tee "$LOG_FILE"

# Синхронизация с локального на удалённый
echo "Синхронизация LOCAL -> REMOTE..." | tee -a "$LOG_FILE"
rsync -avz --delete $EXCLUDE_ARGS \
    "$LOCAL_DIR/" \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" \
    2>&1 | tee -a "$LOG_FILE"

LOCAL_TO_REMOTE_STATUS=$?

# Синхронизация с удалённого на локальный
echo "Синхронизация REMOTE -> LOCAL..." | tee -a "$LOG_FILE"
rsync -avz --delete $EXCLUDE_ARGS \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" \
    "$LOCAL_DIR/" \
    2>&1 | tee -a "$LOG_FILE"

REMOTE_TO_LOCAL_STATUS=$?

# Формирование отчёта
REPORT="Отчёт о синхронизации\n"
REPORT+="Время: $(date)\n"
REPORT+="Локальная директория: $LOCAL_DIR\n"
REPORT+="Удалённая директория: $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR\n\n"

if [ $LOCAL_TO_REMOTE_STATUS -eq 0 ] && [ $REMOTE_TO_LOCAL_STATUS -eq 0 ]; then
    REPORT+="Статус: УСПЕШНО\n"
else
    REPORT+="Статус: ОШИБКА\n"
fi

REPORT+="\nПодробности в файле: $LOG_FILE"

# Отправка отчёта
echo -e "$REPORT" | mail -s "Отчёт о синхронизации файлов" "$EMAIL"
echo -e "$REPORT"
