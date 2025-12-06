
#!/usr/bin/env bash
read -p "Введите команду для запуска в фоне: " -r cmdline
# запускаем через sh -c чтобы поддерживать сложные команды
sh -c "$cmdline" &
pid=$!
echo "Команда запущена в фоне, PID = $pid"
