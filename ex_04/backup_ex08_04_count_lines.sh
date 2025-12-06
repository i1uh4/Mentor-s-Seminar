
#!/usr/bin/env bash
read -p "Укажите файл: " f
if [ ! -f "$f" ]; then
  echo "Файл не найден."
  exit 1
fi
lines=$(wc -l < "$f")
echo "Количество строк: $lines"
