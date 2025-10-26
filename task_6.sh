#!/bin/bash

if [ ! -f input.txt ]; then
    echo "Файл input.txt не найден!"
else
    cat input.txt
fi

wc -l input.txt > output.txt
ls not_existing_file 2> error.log

echo "Результаты записаны в output.txt, ошибки — в error.log"
