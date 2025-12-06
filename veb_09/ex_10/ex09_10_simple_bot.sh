
#!/usr/bin/env bash
echo "Введите команду (Дата, Время, Привет, Выход):"
while true; do
  read -p "> " cmd
  case "${cmd,,}" in
    дата|date) date '+%F' ;;
    время|time) date '+%T' ;;
    привет|hi) echo "Привет!" ;;
    выход|exit|quit) echo "Выход."; break ;;
    *) echo "Неизвестная команда." ;;
  esac
done
