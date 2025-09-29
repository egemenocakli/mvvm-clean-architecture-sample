// =======================================================
// Dosya: /Domain/UseCases/ClearHistoryUseCase.swift
// Sayfa görevi: Geçmişi temizleme iş akışını yönetir.
// Katman: Domain/UseCases
// =======================================================

import Foundation

public protocol ClearHistoryUseCase {
    /// Metod görevi: Tüm geçmiş kayıtlarını temizler.
    func execute() throws
}

public final class DefaultClearHistoryUseCase: ClearHistoryUseCase {
    private let history: HistoryRepository

    /// Init görevi: HistoryRepository bağımlılığı ile kurulum yapar.
    public init(history: HistoryRepository) { self.history = history }

    /// Metod görevi: Tüm geçmişi temizler.
    public func execute() throws { try history.clear() }
}
