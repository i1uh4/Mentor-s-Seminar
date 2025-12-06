#!/usr/bin/env bash

read -p "Введите имя: " name
read -p "Введите возраст (целое число): " age

if ! [[ "$age" =~ ^[0-9]+$ ]]; then
  echo "Возраст должен быть целым числом."
  exit 1
fi

next=$((age + 1))
echo "Привет, $name! Через год тебе будет $next лет."
