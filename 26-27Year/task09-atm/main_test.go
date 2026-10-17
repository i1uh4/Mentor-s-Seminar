package main

import (
	"errors"
	"testing"
)

func TestDeposit(t *testing.T) {
	got, err := deposit(50, 25.5)
	if err != nil || got != 75.5 {
		t.Errorf("deposit(50, 25.5) = (%v, %v), want (75.5, nil)", got, err)
	}

	if _, err := deposit(50, -10); !errors.Is(err, ErrInvalidAmount) {
		t.Errorf("deposit(50, -10): ошибка = %v, want %v", err, ErrInvalidAmount)
	}
}

func TestWithdraw(t *testing.T) {
	tests := []struct {
		name    string
		balance float64
		amount  float64
		want    float64
		wantErr error
	}{
		{"обычное снятие", 100, 30, 70, nil},
		{"снятие всей суммы", 100, 100, 0, nil},
		{"недостаточно средств", 100, 150, 100, ErrInsufficientFunds},
		{"нулевая сумма", 100, 0, 100, ErrInvalidAmount},
		{"отрицательная сумма", 100, -5, 100, ErrInvalidAmount},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := withdraw(tt.balance, tt.amount)
			if !errors.Is(err, tt.wantErr) {
				t.Fatalf("ошибка = %v, want %v", err, tt.wantErr)
			}
			if got != tt.want {
				t.Errorf("баланс = %v, want %v", got, tt.want)
			}
		})
	}
}
