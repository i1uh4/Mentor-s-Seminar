package main

import "testing"

func TestCalculateStats(t *testing.T) {
	tests := []struct {
		name string
		nums []int
		want Stats
	}{
		{"одно отрицательное", []int{-3}, Stats{Sum: -3, Average: -3, Max: -3, Min: -3, Even: 0, Odd: 1}},
		{"от 1 до 5", []int{1, 2, 3, 4, 5}, Stats{Sum: 15, Average: 3, Max: 5, Min: 1, Even: 2, Odd: 3}},
		{"смешанные знаки", []int{-4, 7, 0}, Stats{Sum: 3, Average: 1, Max: 7, Min: -4, Even: 2, Odd: 1}},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := calculateStats(tt.nums); got != tt.want {
				t.Errorf("calculateStats(%v) = %+v, want %+v", tt.nums, got, tt.want)
			}
		})
	}
}
