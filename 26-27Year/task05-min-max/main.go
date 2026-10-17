package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func minMax(nums []float64) (float64, float64) {
	lo, hi := nums[0], nums[0]
	for _, v := range nums[1:] {
		if v < lo {
			lo = v
		}
		if v > hi {
			hi = v
		}
	}
	return lo, hi
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readPositiveInt(scanner, "Сколько чисел вы введёте? N = ")
	nums := make([]float64, 0, n)
	for i := 1; i <= n; i++ {
		nums = append(nums, readFloat(scanner, fmt.Sprintf("Введите число %d из %d: ", i, n)))
	}

	lo, hi := minMax(nums)
	fmt.Printf("Минимальное значение: %g\n", lo)
	fmt.Printf("Максимальное значение: %g\n", hi)
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
