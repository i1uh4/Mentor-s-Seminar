#!/bin/bash

echo "Текущее значение PATH:"
echo $PATH

if [ -z "$1" ]; then
    echo "Не указана директория для добавления!"
    exit 1
fi

NEW_PATH=$1
export PATH=$PATH:$NEW_PATH
echo "Новое значение PATH:"
echo $PATH

echo ""
echo "Изменения PATH временные, они исчезнут после закрытия терминала."
echo "Чтобы сделать их постоянными, добавьте эту строку в ~/.bashrc:"
echo "export PATH=\$PATH:$NEW_PATH"
echo "После этого перезапустите терминал или выполните: source ~/.bashrc"
