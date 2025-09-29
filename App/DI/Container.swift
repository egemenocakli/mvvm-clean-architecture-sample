// =======================================================
// Dosya: /App/DI/Container.swift
// Sayfa görevi: Uygulamanın bağımlılıklarını (UseCase/Repository) oluşturup hazırlar (Composition Root).
// Katman: App/DI
// =======================================================

import Foundation
import Domain
import Data

struct AppContainer {
    let evaluateUseCase: EvaluateExpressionUseCase
    let getHistoryUseCase: GetHistoryUseCase
    let clearHistoryUseCase: ClearHistoryUseCase

    /// Metod görevi: Canlı (production) bağımlılıkları kurup container döndürür.
    static func live() -> AppContainer {
        let engine = InMemoryCalculatorEngineRepository()
        let history = UserDefaultsHistoryRepository()

        let evaluate = DefaultEvaluateExpressionUseCase(engine: engine, history: history)
        let getH = DefaultGetHistoryUseCase(history: history)
        let clearH = DefaultClearHistoryUseCase(history: history)

        return AppContainer(
            evaluateUseCase: evaluate,
            getHistoryUseCase: getH,
            clearHistoryUseCase: clearH
        )
    }
}
