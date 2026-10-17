package main

import (
	"reflect"
	"testing"
)

func TestSumSuitable(t *testing.T) {
	tests := []struct {
		n       int
		wantSum int
		want    []int
	}{
		{5, 0, nil},
		{6, 6, []int{6}},
		{12, 18, []int{6, 12}},
		{30, 90, []int{6, 12, 18, 24, 30}},
	}

	for _, tt := range tests {
		sum, numbers := sumSuitable(tt.n)
		if sum != tt.wantSum || !reflect.DeepEqual(numbers, tt.want) {
			t.Errorf("sumSuitable(%d) = (%d, %v), want (%d, %v)", tt.n, sum, numbers, tt.wantSum, tt.want)
		}
	}
}
