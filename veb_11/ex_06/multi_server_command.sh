#!/bin/bash
# multi_server_command.sh

SERVERS_FILE="servers.txt"
COMMAND="uptime"  # Команда по умолчанию
LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/multi_server_$(date +%Y%m%d_%H%M%S).log"

# Проверка аргументов
if [ $# -ge 1 ]; then
    COMMAND="$@"
fi

# Создание директории для логов
mkdir -p "$LOG_DIR"

echo "Выполнение команды на серверах: $COMMAND" | tee "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

# Проверка наличия файла серверов
if [ ! -f "$SERVERS_FILE" ]; then
    echo "Создайте файл $SERVERS_FILE со списком серверов (формат: user@host)"
    exit 1
fi

# Чтение серверов и выполнение команды
while IFS= read -r server; do
    # Пропуск пустых строк и комментариев
    [[ -z "$server" || "$server" =~ ^# ]] && continue
    
    echo "" | tee -a "$LOG_FILE"
    echo "Сервер: $server" | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    
    # Выполнение команды
    ssh -o ConnectTimeout=10 "$server" "$COMMAND" 2>&1 | tee -a "$LOG_FILE"
    
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        echo "Статус: УСПЕШНО" | tee -a "$LOG_FILE"
    else
        echo "Статус: ОШИБКА" | tee -a "$LOG_FILE"
    fi
    
done < "$SERVERS_FILE"

echo "" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"
echo "Лог сохранён в: $LOG_FILE" | tee -a "$LOG_FILE"
