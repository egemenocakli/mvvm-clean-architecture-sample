// =======================================================
// Dosya: /Domain/UseCases/EvaluateExpressionUseCase.swift
// Sayfa görevi: İşlemi hesaplama ve sonucu geçmişe yazma akışını yönetir (UseCase).
// Katman: Domain/UseCases
// =======================================================

import Foundation

public protocol EvaluateExpressionUseCase {
    /// Metod görevi: Verilen operandlar ve işlem ile sonucu hesaplayıp döndürür.
    func execute(lhs: Decimal, rhs: Decimal, op: CalculatorOperation) throws -> Decimal
}

public final class DefaultEvaluateExpressionUseCase: EvaluateExpressionUseCase {
    private let engine: CalculatorEngineRepository
    private let history: HistoryRepository

    /// Init görevi: UseCase'i gerekli bağımlılıklarla kurar.
    public init(engine: CalculatorEngineRepository, history: HistoryRepository) {
        self.engine = engine
        self.history = history
    }

    /// Metod görevi: Hesaplamayı motor aracılığıyla yapar, sonucu formatlar ve geçmişe kaydeder.
    public func execute(lhs: Decimal, rhs: Decimal, op: CalculatorOperation) throws -> Decimal {
        let value = try engine.apply(op, lhs: lhs, rhs: rhs)

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10

        let lhsStr = formatter.string(from: lhs as NSNumber) ?? "\(lhs)"
        let rhsStr = formatter.string(from: rhs as NSNumber) ?? "\(rhs)"
        let resStr = formatter.string(from: value as NSNumber) ?? "\(value)"
        let expr = "\(lhsStr) \(op.symbol) \(rhsStr)"
        try history.save(HistoryItem(expression: expr, result: resStr))
        return value
    }
}
