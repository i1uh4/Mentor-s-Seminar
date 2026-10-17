package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var ErrDivisionByZero = errors.New("деление на ноль невозможно")

func calculate(a, b float64, op string) (float64, error) {
	switch op {
	case "+":
		return a + b, nil
	case "-":
		return a - b, nil
	case "*":
		return a * b, nil
	case "/":
		if b == 0 {
			return 0, ErrDivisionByZero
		}
		return a / b, nil
	default:
		return 0, fmt.Errorf("неизвестная операция %q", op)
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	a := readFloat(scanner, "Введите первое число: ")
	b := readFloat(scanner, "Введите второе число: ")
	op := readOperation(scanner)

	result, err := calculate(a, b, op)
	if err != nil {
		fmt.Println("Ошибка:", err)
		return
	}

	fmt.Printf("Результат: %g %s %g = %g\n", a, op, b, result)
}

func readOperation(scanner *bufio.Scanner) string {
	for {
		op := readLine(scanner, "Введите операцию (+, -, *, /): ")
		switch op {
		case "+", "-", "*", "/":
			return op
		default:
			fmt.Println("Ошибка: допустимы только +, -, * или /.")
		}
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
