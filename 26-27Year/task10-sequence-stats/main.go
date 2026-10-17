package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Stats struct {
	Sum     int
	Average float64
	Max     int
	Min     int
	Even    int
	Odd     int
}

func calculateStats(nums []int) Stats {
	s := Stats{Max: nums[0], Min: nums[0]}
	for _, n := range nums {
		s.Sum += n
		if n > s.Max {
			s.Max = n
		}
		if n < s.Min {
			s.Min = n
		}
		if n%2 == 0 {
			s.Even++
		} else {
			s.Odd++
		}
	}
	s.Average = float64(s.Sum) / float64(len(nums))
	return s
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n := readPositiveInt(scanner, "Сколько чисел вы введёте? N = ")
	nums := make([]int, 0, n)
	for i := 1; i <= n; i++ {
		nums = append(nums, readInt(scanner, fmt.Sprintf("Введите число %d из %d: ", i, n)))
	}

	s := calculateStats(nums)

	fmt.Println("\nСтатистика последовательности:")
	fmt.Printf("Сумма всех чисел: %d\n", s.Sum)
	fmt.Printf("Среднее значение: %.2f\n", s.Average)
	fmt.Printf("Максимальное значение: %d\n", s.Max)
	fmt.Printf("Минимальное значение: %d\n", s.Min)
	fmt.Printf("Количество чётных чисел: %d\n", s.Even)
	fmt.Printf("Количество нечётных чисел: %d\n", s.Odd)
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
