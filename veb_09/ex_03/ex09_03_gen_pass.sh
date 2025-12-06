
#!/usr/bin/env bash
len=${1:-12}
if ! [[ "$len" =~ ^[0-9]+$ ]]; then
  echo "Длина должна быть числом."
  exit 1
fi
# /dev/urandom, фильтруем буквы и цифры, берем первые len символов
pass=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "$len")
echo "Сгенерированный пароль: $pass"
