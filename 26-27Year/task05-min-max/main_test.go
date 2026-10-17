package main

import "testing"

func TestMinMax(t *testing.T) {
	tests := []struct {
		name   string
		nums   []float64
		wantLo float64
		wantHi float64
	}{
		{"одно число", []float64{7}, 7, 7},
		{"положительные", []float64{3, 9, 1, 4}, 1, 9},
		{"с отрицательными", []float64{-5, 2, -10, 0}, -10, 2},
		{"дробные", []float64{0.5, -0.25, 1.75}, -0.25, 1.75},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			lo, hi := minMax(tt.nums)
			if lo != tt.wantLo || hi != tt.wantHi {
				t.Errorf("minMax(%v) = (%v, %v), want (%v, %v)", tt.nums, lo, hi, tt.wantLo, tt.wantHi)
			}
		})
	}
}
