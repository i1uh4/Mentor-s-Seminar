package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func countSigns(nums []float64) (positive, negative, zero int) {
	for _, v := range nums {
		if v > 0 {
			positive++
		} else if v < 0 {
			negative++
		} else {
			zero++
		}
	}
	return positive, negative, zero
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readPositiveInt(scanner, "Сколько чисел вы введёте? N = ")
	nums := make([]float64, 0, n)
	for i := 1; i <= n; i++ {
		nums = append(nums, readFloat(scanner, fmt.Sprintf("Введите число %d из %d: ", i, n)))
	}

	positive, negative, zero := countSigns(nums)
	fmt.Printf("Положительных чисел: %d\n", positive)
	fmt.Printf("Отрицательных чисел: %d\n", negative)
	fmt.Printf("Нулей: %d\n", zero)
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

func readFloat(scanner *bufio.Scanner, prompt string) float64 {
	for {
		text := strings.ReplaceAll(readLine(scanner, prompt), ",", ".")
		value, err := strconv.ParseFloat(text, 64)
		if err == nil {
			return value
		}
		fmt.Println("Ошибка: введите число, например 12 или 3.5.")
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
