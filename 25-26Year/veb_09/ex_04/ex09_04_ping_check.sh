
#!/usr/bin/env bash
host=${1:-8.8.8.8}
if ping -c 1 -W 2 "$host" >/dev/null 2>&1; then
  echo "Сервер $host доступен."
else
  echo "Сервер $host недоступен."
fi
