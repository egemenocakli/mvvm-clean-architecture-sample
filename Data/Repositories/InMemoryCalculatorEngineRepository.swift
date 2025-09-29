// =======================================================
// Dosya: /Data/Repositories/InMemoryCalculatorEngineRepository.swift
// Sayfa görevi: Domain'deki CalculatorEngineRepository için basit (bellek içi) implementasyon.
// Katman: Data/Repositories (altyapı - UI'dan bağımsız, domain'e hizmet eder)
// =======================================================

import Foundation
import Domain

public final class InMemoryCalculatorEngineRepository: CalculatorEngineRepository {
    public init() {}

    /// Metod görevi: Seçili işleme göre sonucu hesaplar. Bölme için sıfıra bölmeyi engeller.
    public func apply(_ op: CalculatorOperation, lhs: Decimal, rhs: Decimal) throws -> Decimal {
        switch op {
        case .add: return lhs + rhs
        case .subtract: return lhs - rhs
        case .multiply: return lhs * rhs
        case .divide:
            if rhs == 0 { throw CalculatorError.divideByZero }
            return lhs / rhs
        }
    }
}
