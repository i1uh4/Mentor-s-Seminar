package main

import "testing"

func TestSumAndAverage(t *testing.T) {
	tests := []struct {
		n       int
		wantSum int
		wantAvg float64
	}{
		{1, 1, 1},
		{4, 10, 2.5},
		{10, 55, 5.5},
		{100, 5050, 50.5},
	}

	for _, tt := range tests {
		sum, avg := sumAndAverage(tt.n)
		if sum != tt.wantSum || avg != tt.wantAvg {
			t.Errorf("sumAndAverage(%d) = (%d, %v), want (%d, %v)", tt.n, sum, avg, tt.wantSum, tt.wantAvg)
		}
	}
}
