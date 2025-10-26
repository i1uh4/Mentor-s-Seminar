#!/bin/bash
# Резервное копирование с логом

SRC=$1
DEST="backup_$(date +%Y%m%d)"
LOG="backup.log"

mkdir -p "$DEST"
COUNT=0

for f in "$SRC"/*; do
    cp "$f" "$DEST/$(basename "$f")_$(date +%Y%m%d)"
    ((COUNT++))
done

echo "$(date): Создана резервная копия $COUNT файлов из $SRC в $DEST" >> "$LOG"
echo "Резервное копирование завершено. Сохранено $COUNT файлов."
