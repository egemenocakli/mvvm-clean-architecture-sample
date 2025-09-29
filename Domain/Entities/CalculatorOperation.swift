// =======================================================
// Dosya: /Domain/Entities/CalculatorOperation.swift
// Sayfa görevi: Hesaplama işlemlerini (topla/çıkar/çarp/böl) domain seviyesinde temsil eder.
// Katman: Domain/Entities (UI'dan bağımsız iş kuralları modelleri)
// =======================================================

import Foundation

public enum CalculatorOperation: String, Codable, CaseIterable, Equatable {
    /// Özellik görevi: İşlemin kullanıcıya gösterilecek sembolünü döndürür.
    public var symbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }

    case add, subtract, multiply, divide
}
