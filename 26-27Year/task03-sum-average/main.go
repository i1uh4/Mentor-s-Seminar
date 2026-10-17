package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func sumAndAverage(n int) (int, float64) {
	sum := 0
	for i := 1; i <= n; i++ {
		sum += i
	}
	average := float64(sum) / float64(n)
	return sum, average
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readPositiveInt(scanner, "Введите натуральное число N: ")
	sum, average := sumAndAverage(n)

	fmt.Printf("Сумма чисел от 1 до %d: %d\n", n, sum)
	fmt.Printf("Среднее значение: %.2f\n", average)
}

func readPositiveInt(scanner *bufio.Scanner, prompt string) int {
	for {
		value, err := strconv.Atoi(readLine(scanner, prompt))
		if err == nil && value > 0 {
			return value
		}
		fmt.Println("Ошибка: введите целое число больше нуля.")
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
