#!/bin/bash
# Сортировка файлов по типам

DIR=$1
LOG="sort_log.txt"
mkdir -p "$DIR/Images" "$DIR/Documents"

for f in "$DIR"/*; do
    if [[ "$f" == *.jpg || "$f" == *.png || "$f" == *.gif ]]; then
        mv "$f" "$DIR/Images/"
        echo "$(date): Перемещен $f в Images" >> "$LOG"
    elif [[ "$f" == *.txt || "$f" == *.pdf || "$f" == *.docx ]]; then
        mv "$f" "$DIR/Documents/"
        echo "$(date): Перемещен $f в Documents" >> "$LOG"
    fi
done

echo "Файлы отсортированы. Подробности в $LOG."
echo "Для автоматического запуска добавьте в cron строку:"
echo "0 0 * * * /путь/к/скрипту.sh /папка/для/сортировки"
