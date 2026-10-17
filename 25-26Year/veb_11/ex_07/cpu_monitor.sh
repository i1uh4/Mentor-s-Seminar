

### Упражнение 7: Мониторинг загрузки CPU

```bash
#!/bin/bash
# cpu_monitor.sh

REMOTE_USER="user"
REMOTE_HOST="remote.server.com"
CPU_THRESHOLD=2.0  # Средняя загрузка CPU
PROCESS_TO_KILL="stress"  # Процесс для завершения

echo "Мониторинг загрузки CPU на $REMOTE_HOST..."

# Получение загрузки CPU
CPU_LOAD=$(ssh "$REMOTE_USER@$REMOTE_HOST" "uptime | awk -F'load average:' '{print \$2}' | awk -F',' '{print \$1}' | xargs")

echo "Текущая средняя загрузка: $CPU_LOAD"

# Сравнение с порогом
if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
    echo "ВНИМАНИЕ: Загрузка CPU превышает порог ($CPU_THRESHOLD)"
    
    # Поиск и завершение процессов
    ssh "$REMOTE_USER@$REMOTE_HOST" << ENDSSH
        echo "Поиск процессов '$PROCESS_TO_KILL'..."
        PIDS=\$(pgrep "$PROCESS_TO_KILL")
        
        if [ -n "\$PIDS" ]; then
            echo "Найдены процессы: \$PIDS"
            echo "Завершение процессов..."
            pkill "$PROCESS_TO_KILL"
            echo "Процессы завершены"
        else
            echo "Процессы '$PROCESS_TO_KILL' не найдены"
            
            # Показать топ процессов по CPU
            echo "Топ процессов по использованию CPU:"
            ps aux --sort=-%cpu | head -10
        fi
ENDSSH
else
    echo "OK: Загрузка CPU в норме"
fi
