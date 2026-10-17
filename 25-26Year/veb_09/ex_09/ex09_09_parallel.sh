
#!/usr/bin/env bash
# Пример: ./ex09_09_parallel.sh "sleep 1" "sleep 2" "ls -la"
if [ $# -lt 1 ]; then
  echo "Укажите команды в аргументах."
  exit 1
fi

pids=()
for cmd in "$@"; do
  sh -c "$cmd" &
  pids+=($!)
  echo "Запущено: '$cmd' PID=${pids[-1]}"
done

# ожидание всех
for pid in "${pids[@]}"; do
  wait "$pid"
  echo "Процесс $pid завершён с кодом $?"
done
