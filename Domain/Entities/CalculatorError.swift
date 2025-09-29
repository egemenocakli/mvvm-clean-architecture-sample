// =======================================================
// Dosya: /Domain/Entities/CalculatorError.swift
// Sayfa görevi: Hesaplama sırasında oluşabilecek domain hatalarını tanımlar.
// Katman: Domain/Entities
// =======================================================

import Foundation

public enum CalculatorError: Error, Equatable {
    case divideByZero
    case invalidNumber
}
