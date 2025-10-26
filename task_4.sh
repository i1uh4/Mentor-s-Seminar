#!/bin/bash

say_hello() {
    echo "Hello, $1"
}

sum_numbers() {
    local s=$(( $1 + $2 ))
    echo $s
}

say_hello "World"
result=$(sum_numbers 5 7)
echo "Сумма чисел: $result"
