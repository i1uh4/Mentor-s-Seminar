#!/bin/bash
# Мониторинг системных ресурсов

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK=$(df -h / | awk 'NR==2 {print $5}')

echo "Загрузка CPU: $CPU%"
echo "Использование памяти: $MEM%"
echo "Использование диска: $DISK"

if (( $(echo "$MEM > 80" | bc -l) )); then
    echo "Внимание! Использование памяти выше 80%"
    echo "Топ процессов по памяти:"
    ps aux --sort=-%mem | head -5
fi
