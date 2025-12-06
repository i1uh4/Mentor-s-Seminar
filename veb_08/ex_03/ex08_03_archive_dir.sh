
#!/usr/bin/env bash
read -p "Укажите директорию для архивации: " dir
if [ ! -d "$dir" ]; then
  echo "Директория не найдена."
  exit 1
fi
stamp=$(date +%F)   # YYYY-MM-DD
dest="${dir%/}_backup_${stamp}.tar.gz"
tar -czf "$dest" -C "$(dirname "$dir")" "$(basename "$dir")"
echo "Создан архив: $dest"
