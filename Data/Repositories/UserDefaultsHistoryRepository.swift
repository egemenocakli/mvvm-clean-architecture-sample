// =======================================================
// Dosya: /Data/Repositories/UserDefaultsHistoryRepository.swift
// Sayfa görevi: İşlem geçmişini UserDefaults üzerinde kalıcı olarak saklar.
// Katman: Data/Repositories
// =======================================================

import Foundation
import Domain

public final class UserDefaultsHistoryRepository: HistoryRepository {
    private let key = "calc_history"
    private let defaults: UserDefaults

    /// Init görevi: UserDefaults bağımlılığı ile kurulum yapar.
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    /// Metod görevi: Yeni bir HistoryItem'ı var olan dizinin sonuna ekleyip kalıcı hale getirir.
    public func save(_ item: HistoryItem) throws {
        var arr = try getAll()
        arr.append(item)
        try persist(arr)
    }

    /// Metod görevi: Tüm geçmişi okur ve döndürür.
    public func getAll() throws -> [HistoryItem] {
        guard let data = defaults.data(forKey: key) else { return [] }
        let items = try JSONDecoder().decode([HistoryItem].self, from: data)
        return items
    }

    /// Metod görevi: Tüm geçmişi temizler.
    public func clear() throws {
        try persist([])
    }

    /// Metod görevi: Verilen dizi verisini JSON'a çevirip UserDefaults'a yazar.
    private func persist(_ items: [HistoryItem]) throws {
        let data = try JSONEncoder().encode(items)
        defaults.set(data, forKey: key)
    }
}
