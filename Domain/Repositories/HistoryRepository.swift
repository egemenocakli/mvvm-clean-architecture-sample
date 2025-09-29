// =======================================================
// Dosya: /Domain/Repositories/HistoryRepository.swift
// Sayfa görevi: İşlem geçmişi için domain tarafında bir soyutlama sunar.
// Katman: Domain/Repositories
// =======================================================

import Foundation

public protocol HistoryRepository {
    /// Metod görevi: Yeni bir geçmiş kaydını kalıcı olarak saklar.
    func save(_ item: HistoryItem) throws
    /// Metod görevi: Tüm geçmiş kayıtlarını döndürür.
    func getAll() throws -> [HistoryItem]
    /// Metod görevi: Tüm geçmişi temizler.
    func clear() throws
}
