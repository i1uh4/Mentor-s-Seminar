
#!/usr/bin/env bash
dir=${1:-.}
if [ ! -d "$dir" ]; then
  echo "Директория не найдена."
  exit 1
fi

shopt -s nullglob
for f in "$dir"/*; do
  base=$(basename "$f")
  lower=$(echo "$base" | tr 'A-Z' 'a-z')
  if [ "$base" != "$lower" ]; then
    mv -n "$dir/$base" "$dir/$lower"
  fi
done
echo "Переименование завершено."
