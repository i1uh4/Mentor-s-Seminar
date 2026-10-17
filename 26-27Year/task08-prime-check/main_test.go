package main

import "testing"

func TestIsPrime(t *testing.T) {
	tests := []struct {
		n    int
		want bool
	}{
		{-7, false},
		{0, false},
		{1, false},
		{2, true},
		{3, true},
		{4, false},
		{9, false},
		{17, true},
		{25, false},
		{97, true},
		{100, false},
		{7919, true},
	}

	for _, tt := range tests {
		if got := isPrime(tt.n); got != tt.want {
			t.Errorf("isPrime(%d) = %v, want %v", tt.n, got, tt.want)
		}
	}
}
