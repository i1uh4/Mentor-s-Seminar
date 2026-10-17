
#!/usr/bin/env bash
file=${1:?Укажите файл в аргументе}
if [ ! -f "$file" ]; then
  echo "Файл не найден."
  exit 1
fi

last=$(stat -c %Y "$file")
echo "Отслеживание изменений для $file (Ctrl+C для выхода)..."
while true; do
  sleep 2
  cur=$(stat -c %Y "$file")
  if [ "$cur" -ne "$last" ]; then
    echo "Файл $file изменён в $(date -d @"$cur" '+%F %T')"
    last=$cur
  fi
done
