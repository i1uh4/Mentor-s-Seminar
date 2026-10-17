package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var (
	ErrInsufficientFunds = errors.New("недостаточно средств на балансе")
	ErrInvalidAmount = errors.New("сумма должна быть больше нуля")
)

func deposit(balance, amount float64) (float64, error) {
	if amount <= 0 {
		return balance, ErrInvalidAmount
	}
	return balance + amount, nil
}

func withdraw(balance, amount float64) (float64, error) {
	if amount <= 0 {
		return balance, ErrInvalidAmount
	}
	if amount > balance {
		return balance, ErrInsufficientFunds
	}
	return balance - amount, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	balance := readFloat(scanner, "Введите начальный баланс: ")
	for balance < 0 {
		fmt.Println("Ошибка: баланс не может быть отрицательным.")
		balance = readFloat(scanner, "Введите начальный баланс: ")
	}

	for {
		printMenu()
		choice := readLine(scanner, "Выберите действие: ")

		switch choice {
		case "1":
			fmt.Printf("Текущий баланс: %.2f\n", balance)
		case "2":
			amount := readFloat(scanner, "Сумма пополнения: ")
			newBalance, err := deposit(balance, amount)
			if err != nil {
				fmt.Println("Ошибка:", err)
			} else {
				balance = newBalance
				fmt.Printf("Баланс пополнен. Текущий баланс: %.2f\n", balance)
			}
		case "3":
			amount := readFloat(scanner, "Сумма снятия: ")
			newBalance, err := withdraw(balance, amount)
			if err != nil {
				fmt.Println("Ошибка:", err)
			} else {
				balance = newBalance
				fmt.Printf("Выдано %.2f. Текущий баланс: %.2f\n", amount, balance)
			}
		case "0":
			fmt.Println("Спасибо за использование банкомата!")
			return
		default:
			fmt.Println("Неизвестный пункт меню, попробуйте снова.")
		}
		fmt.Println()
	}
}

func printMenu() {
	fmt.Println("Меню:")
	fmt.Println("  1 — посмотреть баланс")
	fmt.Println("  2 — пополнить баланс")
	fmt.Println("  3 — снять средства")
	fmt.Println("  0 — выход")
}

func readFloat(scanner *bufio.Scanner, prompt string) float64 {
	for {
		text := strings.ReplaceAll(readLine(scanner, prompt), ",", ".")
		value, err := strconv.ParseFloat(text, 64)
		if err == nil {
			return value
		}
		fmt.Println("Ошибка: введите число, например 1500 или 99.5.")
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
