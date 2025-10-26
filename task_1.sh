#!/bin/bash

echo "Список всех файлов и папок в текущей директории:"
for item in *; do
    if [ -d "$item" ]; then
        echo "$item — это каталог"
    elif [ -f "$item" ]; then
        echo "$item — это файл"
    else
        echo "$item — другой тип"
    fi
done

# Проверка существования файла
if [ -z "$1" ]; then
    echo "Вы не указали имя файла для проверки!"
else
    if [ -e "$1" ]; then
        echo "Файл $1 найден!"
    else
        echo "Файл $1 не существует."
    fi
fi

# Выводим права доступа
echo "Информация о файлах:"
for f in *; do
    echo "$f — права: $(ls -l "$f" | awk '{print $1}')"
done
