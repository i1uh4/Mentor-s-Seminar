package main

import "testing"

func TestCountSigns(t *testing.T) {
	positive, negative, zero := countSigns([]float64{3, -1, 0, 0, 7.5, -2.25, -8})
	if positive != 2 || negative != 3 || zero != 2 {
		t.Errorf("countSigns = (%d, %d, %d), want (2, 3, 2)", positive, negative, zero)
	}

	positive, negative, zero = countSigns(nil)
	if positive != 0 || negative != 0 || zero != 0 {
		t.Errorf("countSigns(nil) = (%d, %d, %d), want (0, 0, 0)", positive, negative, zero)
	}
}
