
#!/usr/bin/env bash
dir=${1:-.}
# найти лог-файлы (*.log), показать время изменения и сортировать по времени возрастания
find "$dir" -type f -name '*.log' -printf '%T@ %p\n' | sort -n | head -n 5 | awk '{ $1=""; print substr($0,2) }'
