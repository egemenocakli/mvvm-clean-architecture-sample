// =======================================================
// Dosya: /Shared/Constants.swift
// Sayfa görevi: Uygulama genelinde kullanılan sabitleri ve yardımcıları barındırır.
// Katman: Shared (UI ve Domain bağımsız ortak değerler)
// =======================================================

import Foundation

/// Yapı görevi: UI ile ilgili sayısal sabitleri merkezi olarak tutar.
enum UIConstants {
    static let cornerRadius: Double = 16
    static let buttonSpacing: Double = 12
    static let gridSpacing: Double = 12
    static let displayFontSize: Double = 48
}

/// Yapı görevi: Bölgesel ayarlara bağlı yardımcı bilgileri sağlar.
enum LocaleHelpers {
    /// Metod görevi: Geçerli bölgenin ondalık ayırıcısını döndürür.
    static var decimalSeparator: String {
        Locale.current.decimalSeparator ?? "."
    }
}
