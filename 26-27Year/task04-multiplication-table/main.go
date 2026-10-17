package main

import "fmt"

func printTable(n int) {
	fmt.Printf("Таблица умножения на %d:\n", n)
	for i := 1; i <= 10; i++ {
		fmt.Printf("%d x %d = %d\n", n, i, n*i)
	}
}

func main() {
	for n := 1; n <= 10; n++ {
		printTable(n)
		fmt.Println()
	}
}
