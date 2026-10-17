
#!/usr/bin/env bash
read -p "Укажите директорию: " dir
if [ ! -d "$dir" ]; then
  echo "Директория не найдена."
  exit 1
fi
find "$dir" -type f -mtime +7 -print -exec rm -f {} \;
echo "Удаление завершено."
