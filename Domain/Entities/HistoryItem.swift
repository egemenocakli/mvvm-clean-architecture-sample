// =======================================================
// Dosya: /Domain/Entities/HistoryItem.swift
// Sayfa görevi: Yapılan işlemlerin geçmişte nasıl görüneceğini tanımlar.
// Katman: Domain/Entities
// =======================================================

import Foundation

public struct HistoryItem: Codable, Equatable, Identifiable {
    public let id: UUID
    public let expression: String
    public let result: String
    public let date: Date

    /// Init görevi: Geçmiş girdisini ifade, sonuç ve tarih ile oluşturur.
    public init(id: UUID = UUID(), expression: String, result: String, date: Date = Date()) {
        self.id = id
        self.expression = expression
        self.result = result
        self.date = date
    }
}
