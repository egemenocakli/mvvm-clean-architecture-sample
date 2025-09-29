// =======================================================
// Dosya: /Presentation/ViewModels/CalculatorViewModel.swift
// Sayfa görevi: UI durumu ve kullanıcı etkileşimlerini yönetir; yalnızca UseCase'lerle konuşur.
// Katman: Presentation/ViewModels
// =======================================================

import Foundation
import Domain

@MainActor
public final class CalculatorViewModel: ObservableObject {
    // Ekran durumu
    @Published public private(set) var display: String = "0"
    @Published public private(set) var errorMessage: String? = nil
    @Published public private(set) var previousDisplay: String? = nil

    // İç durum
    private var lhs: Decimal? = nil
    private var pendingOp: CalculatorOperation? = nil
    private var isTyping: Bool = false

    // Bağımlılıklar (UseCase'ler)
    private let evaluate: EvaluateExpressionUseCase
    private let getHistory: GetHistoryUseCase
    private let clearHistoryUseCase: ClearHistoryUseCase

    /// Init görevi: ViewModel'i gerekli UseCase bağımlılıkları ile kurar.
    public init(evaluate: EvaluateExpressionUseCase,
                getHistory: GetHistoryUseCase,
                clearHistoryUseCase: ClearHistoryUseCase) {
        self.evaluate = evaluate
        self.getHistory = getHistory
        self.clearHistoryUseCase = clearHistoryUseCase
    }

    // MARK: - Girdi İşleme (Kullanıcı etkileşimi)

    /// Metod görevi: Basılan rakamı ekrana ekler ve yazma durumunu günceller.
    public func inputDigit(_ d: String) {
        guard d.range(of: "^[0-9]$", options: .regularExpression) != nil else { return }
        if isTyping {
            if display == "0" { display = d } else { display += d }
        } else {
            display = d
            isTyping = true
        }
    }

    /// Metod görevi: Ondalık ayırıcıyı ekler (bir kez).
    public func inputDecimal() {
        let sep = Locale.current.decimalSeparator ?? "."
        if !display.contains(sep) {
            display += sep
            isTyping = true
        }
    }

    /// Metod görevi: Sayının işaretini (±) değiştirir.
    public func toggleSign() {
        if display.hasPrefix("-") {
            display.removeFirst()
        } else if display != "0" {
            display = "-" + display
        }
    }

    /// Metod görevi: Ekrandaki sayıyı yüzdeye çevirir.
    public func percent() {
        if let val = Decimal(string: display.replacingOccurrences(of: ",", with: ".")) {
            let res = val / 100
            display = Self.format(res)
            isTyping = false
        }
    }

    /// Metod görevi: Tüm geçici durumu ve ekranı temizler.
    public func clearAll() {
        display = "0"
        previousDisplay = nil
        errorMessage = nil
        lhs = nil
        pendingOp = nil
        isTyping = false
    }

    /// Metod görevi: Seçilen işlemi bekleyen işlem olarak ayarlar ve gerekiyorsa ara hesap yapar.
    public func setOperation(_ op: CalculatorOperation) {
        commitTypingIfNeeded()
        if lhs == nil {
            lhs = Decimal(string: display.replacingOccurrences(of: ",", with: ".")) ?? 0
        } else if let right = Decimal(string: display.replacingOccurrences(of: ",", with: ".")), let currentOp = pendingOp {
            do {
                let val = try evaluate.execute(lhs: lhs ?? 0, rhs: right, op: currentOp)
                lhs = val
                display = Self.format(val)
            } catch {
                handle(error)
                return
            }
        }
        pendingOp = op
        previousDisplay = "\(Self.format(lhs ?? 0)) \(op.symbol)"
        isTyping = false
    }

    /// Metod görevi: Eşittir'e basıldığında mevcut işlemi tamamlar ve sonucu gösterir.
    public func evaluateNow() {
        commitTypingIfNeeded()
        guard let op = pendingOp, let left = lhs,
              let right = Decimal(string: display.replacingOccurrences(of: ",", with: ".")) else { return }
        do {
            let val = try evaluate.execute(lhs: left, rhs: right, op: op)
            display = Self.format(val)
            previousDisplay = nil
            lhs = nil
            pendingOp = nil
            isTyping = false
        } catch {
            handle(error)
        }
    }

    /// Metod görevi: Geçmiş verilerini getirir.
    public func history() -> [HistoryItem] {
        (try? getHistory.execute()) ?? []
    }

    /// Metod görevi: Geçmişi temizler.
    public func clearHistory() {
        try? clearHistoryUseCase.execute()
    }

    // MARK: - Yardımcılar

    /// Metod görevi: Kullanıcı yazıyorsa bu durumu tamamlar (ekran değerini sabitler).
    private func commitTypingIfNeeded() {
        if !isTyping { return }
        isTyping = false
    }

    /// Metod görevi: Hataları kullanıcı dostu mesaja çevirir.
    private func handle(_ error: Error) {
        if let e = error as? CalculatorError, e == .divideByZero {
            errorMessage = NSLocalizedString("error_divide_by_zero", comment: "Divide by zero error")
        } else {
            errorMessage = NSLocalizedString("error_unknown", comment: "Unknown error")
        }
    }

    /// Metod görevi: Decimal değeri yerel ayarlara uygun biçimde string'e çevirir.
    private static func format(_ d: Decimal) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 10
        return f.string(from: d as NSNumber) ?? "\(d)"
    }
}
