// =======================================================
// Dosya: /Presentation/Views/HistoryView.swift
// Sayfa görevi: Hesap geçmişini listeler ve temizleme işlemini sunar.
// Katman: Presentation/Views
// =======================================================

import SwiftUI
import Domain

public struct HistoryView: View {
    /// Özellik görevi: Geçmişi sağlayacak closure (UseCase'i ViewModel üzerinden çağırır).
    let fetch: () -> [HistoryItem]
    /// Özellik görevi: Geçmişi temizleyecek closure.
    let clear: () -> Void

    /// Init görevi: Geçmiş veri sağlayıcılarını dışarıdan alır.
    public init(fetch: @escaping () -> [HistoryItem], clear: @escaping () -> Void) {
        self.fetch = fetch
        self.clear = clear
    }

    /// Görünüm görevi: Geçmiş liste ekranını oluşturur.
    public var body: some View {
        List {
            Section {
                ForEach(fetch()) { item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.expression)
                            .font(.headline)
                        Text(item.result)
                            .font(.title3).bold()
                        Text(item.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption).foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            } header: {
                Text(NSLocalizedString("title_history", comment: ""))
            }
        }
        .toolbar {
            Button(NSLocalizedString("btn_clear_history", comment: "")) {
                clear()
            }
        }
    }
}
