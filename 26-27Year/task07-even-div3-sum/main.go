package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func sumSuitable(n int) (int, []int) {
	sum := 0
	var numbers []int
	for i := 1; i <= n; i++ {
		if i%2 == 0 && i%3 == 0 {
			sum += i
			numbers = append(numbers, i)
		}
	}
	return sum, numbers
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readPositiveInt(scanner, "Введите натуральное число N: ")
	sum, numbers := sumSuitable(n)

	fmt.Printf("Подходящие числа от 1 до %d: %v\n", n, numbers)
	fmt.Printf("Их сумма: %d\n", sum)
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
