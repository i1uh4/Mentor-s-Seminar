#!/usr/bin/env bash
if [ $# -lt 2 ]; then
  echo "Использование: $0 <файл> <слово>"
  exit 1
fi
file=$1
word=$2
if [ ! -f "$file" ]; then
  echo "Файл не найден."
  exit 1
fi
# -o для подсчёта каждого вхождения, -i опционально для нечувствительности к регистру
count=$(grep -o -w "$word" "$file" | wc -l)
echo "Вхождений слова '$word': $count"
