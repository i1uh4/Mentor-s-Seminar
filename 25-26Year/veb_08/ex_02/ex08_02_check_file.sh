
#!/usr/bin/env bash
read -p "Укажите путь к файлу: " f
if [ -e "$f" ]; then
  echo "Файл найден!"
else
  echo "Файл не найден."
fi
