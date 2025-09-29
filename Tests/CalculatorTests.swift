// =======================================================
// Dosya: /Tests/CalculatorTests.swift
// Sayfa görevi: Temel UseCase davranışlarını doğrulayan birim testleri içerir.
// Katman: Tests
// =======================================================

import XCTest
@testable import Domain
@testable import Data
@testable import CalculatorCleanMVVM

final class CalculatorTests: XCTestCase {
    /// Metod görevi: Toplama işleminde 2 + 3 = 5 beklenir.
    func testAddition() throws {
        let engine = InMemoryCalculatorEngineRepository()
        let history = UserDefaultsHistoryRepository()
        let evaluate = DefaultEvaluateExpressionUseCase(engine: engine, history: history)
        let value = try evaluate.execute(lhs: 2, rhs: 3, op: .add)
        XCTAssertEqual(value, 5)
    }

    /// Metod görevi: Sıfıra bölme girişiminde hata fırlatılmalıdır.
    func testDivideByZero() {
        let engine = InMemoryCalculatorEngineRepository()
        let history = UserDefaultsHistoryRepository()
        let evaluate = DefaultEvaluateExpressionUseCase(engine: engine, history: history)
        XCTAssertThrowsError(try evaluate.execute(lhs: 5, rhs: 0, op: .divide))
    }
}
