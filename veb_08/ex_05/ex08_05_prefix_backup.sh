
#!/usr/bin/env bash
read -p "Укажите директорию: " dir
if [ ! -d "$dir" ]; then
  echo "Директория не найдена."
  exit 1
fi

shopt -s nullglob
for f in "$dir"/*; do
  base=$(basename "$f")
  dirn=$(dirname "$f")
  # пропускаем уже имеющие префикс
  if [[ "$base" == backup_* ]]; then
    continue
  fi
  mv -n "$f" "$dirn/backup_$base"
done
echo "Префикс добавлен."
