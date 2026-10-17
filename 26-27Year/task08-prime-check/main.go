package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func isPrime(n int) bool {
	if n < 2 {
		return false
	}
	for i := 2; i*i <= n; i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readInt(scanner, "Введите целое число: ")
	if isPrime(n) {
		fmt.Printf("Число %d простое.\n", n)
	} else {
		fmt.Printf("Число %d не является простым.\n", n)
	}
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
