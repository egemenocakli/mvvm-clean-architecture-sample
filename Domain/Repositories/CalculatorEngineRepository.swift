// =======================================================
// Dosya: /Domain/Repositories/CalculatorEngineRepository.swift
// Sayfa görevi: Hesaplama motoru için domain tarafında bir soyutlama (boundary) sunar.
// Katman: Domain/Repositories (Sadece protokol, implementasyon Data katmanında)
// =======================================================

import Foundation

public protocol CalculatorEngineRepository {
    /// Metod görevi: Verilen işlem ve operandlarla sonucu hesaplar.
    func apply(_ op: CalculatorOperation, lhs: Decimal, rhs: Decimal) throws -> Decimal
}
