// =======================================================
// Dosya: /Domain/UseCases/GetHistoryUseCase.swift
// Sayfa görevi: Geçmişi elde etmek için use case tanımı ve implementasyonu.
// Katman: Domain/UseCases
// =======================================================

import Foundation

public protocol GetHistoryUseCase {
    /// Metod görevi: Tüm geçmiş kayıtlarını (yeni > eski) sıralı şekilde döndürür.
    func execute() throws -> [HistoryItem]
}

public final class DefaultGetHistoryUseCase: GetHistoryUseCase {
    private let history: HistoryRepository

    /// Init görevi: HistoryRepository bağımlılığı ile kurulum yapar.
    public init(history: HistoryRepository) { self.history = history }

    /// Metod görevi: Geçmiş kayıtlarını getirir ve tarihe göre sıralar.
    public func execute() throws -> [HistoryItem] { try history.getAll().sorted { $0.date > $1.date } }
}
