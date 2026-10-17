package main

import (
	"errors"
	"testing"
)

func TestCalculate(t *testing.T) {
	tests := []struct {
		name    string
		a, b    float64
		op      string
		want    float64
		wantErr error
	}{
		{"сложение", 2, 3, "+", 5, nil},
		{"вычитание", 2, 3, "-", -1, nil},
		{"умножение", 4, 2.5, "*", 10, nil},
		{"деление", 9, 3, "/", 3, nil},
		{"деление на ноль", 1, 0, "/", 0, ErrDivisionByZero},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := calculate(tt.a, tt.b, tt.op)
			if !errors.Is(err, tt.wantErr) {
				t.Fatalf("ошибка = %v, ожидалась %v", err, tt.wantErr)
			}
			if got != tt.want {
				t.Errorf("результат = %v, ожидался %v", got, tt.want)
			}
		})
	}
}

func TestCalculateUnknownOperation(t *testing.T) {
	if _, err := calculate(1, 1, "%"); err == nil {
		t.Error("ожидалась ошибка для неизвестной операции")
	}
}
