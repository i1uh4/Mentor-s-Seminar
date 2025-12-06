#!/usr/bin/env bash

if [ $# -lt 3 ]; then
  echo "Использование: $0 TOKEN CHAT_ID 'Текст сообщения'"
  exit 1
fi

TOKEN="$1"
CHAT_ID="$2"
TEXT="$3"

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d text="$TEXT" \
  -d parse_mode="HTML" >/dev/null

echo "Сообщение отправлено (проверьте чат)."
