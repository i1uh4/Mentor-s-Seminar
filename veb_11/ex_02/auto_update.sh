
#!/bin/bash
# auto_update.sh

REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
EMAIL="admin@example.com"
LOG_FILE="/var/log/auto_update.log"

# Функция отправки email
send_email() {
    local subject="$1"
    local body="$2"
    echo "$body" | mail -s "$subject" "$EMAIL"
}

# Подключение и обновление
echo "Подключение к $REMOTE_HOST..." | tee -a "$LOG_FILE"

ssh "$REMOTE_USER@$REMOTE_HOST" << 'ENDSSH' | tee -a "$LOG_FILE"
    # Проверка наличия обновлений
    echo "Проверка обновлений..."
    
    # Для Ubuntu/Debian
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        UPDATES=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
        
        if [ "$UPDATES" -gt 1 ]; then
            echo "Найдено обновлений: $((UPDATES - 1))"
            sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
            
            # Проверка необходимости перезагрузки
            if [ -f /var/run/reboot-required ]; then
                echo "REBOOT_REQUIRED"
                sudo reboot
            fi
        else
            echo "Обновления не найдены"
        fi
    
    # Для CentOS/RHEL
    elif command -v yum &> /dev/null; then
        sudo yum check-update
        if [ $? -eq 100 ]; then
            echo "Установка обновлений..."
            sudo yum update -y
            
            # Проверка необходимости перезагрузки
            if needs-restarting -r &> /dev/null; then
                echo "REBOOT_REQUIRED"
                sudo reboot
            fi
        fi
    fi
ENDSSH

# Проверка результата
if echo "$OUTPUT" | grep -q "REBOOT_REQUIRED"; then
    send_email "Сервер $REMOTE_HOST перезагружен" "Сервер был перезагружен после установки обновлений"
fi
