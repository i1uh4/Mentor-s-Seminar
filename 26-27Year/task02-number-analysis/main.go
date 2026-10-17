package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readInt(scanner, "Введите целое число N: ")

	fmt.Printf("\nАнализ числа %d:\n", n)

	switch {
	case n > 0:
		fmt.Println("  положительное")
	case n < 0:
		fmt.Println("  отрицательное")
	default:
		fmt.Println("  ноль")
	}

	if n%2 == 0 {
		fmt.Println("  чётное")
	} else {
		fmt.Println("  нечётное")
	}

	fmt.Printf("  делится на 3: %s\n", yesNo(n%3 == 0))
	fmt.Printf("  делится на 5: %s\n", yesNo(n%5 == 0))
}

func yesNo(condition bool) string {
	if condition {
		return "да"
	}
	return "нет"
}

func readInt(scanner *bufio.Scanner, prompt string) int {
	for {
		value, err := strconv.Atoi(readLine(scanner, prompt))
		if err == nil {
			return value
		}
		fmt.Println("Ошибка: введите целое число, например 42 или -7.")
	}
}

func readLine(scanner *bufio.Scanner, prompt string) string {
	fmt.Print(prompt)
	if !scanner.Scan() {
		fmt.Println("\nВвод завершён.")
		os.Exit(0)
	}
	return strings.TrimSpace(scanner.Text())
}
