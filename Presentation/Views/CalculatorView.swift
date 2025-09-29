// =======================================================
// Dosya: /Presentation/Views/CalculatorView.swift
// Sayfa görevi: Hesap makinesi ekranını (tuş takımını ve display'i) çizer.
// Katman: Presentation/Views
// =======================================================

import SwiftUI
import Domain

public struct CalculatorView: View {
    @ObservedObject var vm: CalculatorViewModel

    /// Init görevi: ViewModel'i dışarıdan alır ve bağlar.
    public init(vm: CalculatorViewModel) {
        self.vm = vm
    }

    /// Özellik görevi: Tuş takımının satır/sütun düzenini tanımlar.
    let rows: [[CalcKey]] = [
        [.clear, .plusMinus, .percent, .op(.divide)],
        [.digit("7"), .digit("8"), .digit("9"), .op(.multiply)],
        [.digit("4"), .digit("5"), .digit("6"), .op(.subtract)],
        [.digit("1"), .digit("2"), .digit("3"), .op(.add)],
        [.digit("0"), .decimal, .equals]
    ]

    /// Görünüm görevi: UI yapısını oluşturur.
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                if let prev = vm.previousDisplay {
                    Text(prev)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text(vm.display)
                    .font(.system(size: 56, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                if let err = vm.errorMessage {
                    Text(err).foregroundStyle(.red).font(.footnote)
                }
            }
            .padding(.horizontal, 20)

            VStack(spacing: 12) {
                ForEach(rows, id: \.[0].id) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.id) { key in
                            CalculatorButton(key: key) { handle(key) }
                                .frame(width: buttonWidth(for: key), height: 64)
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .navigationTitle(Text(NSLocalizedString("title_calculator", comment: "")))
    }

    /// Metod görevi: Basılan tuşa göre ViewModel'e uygun çağrıyı yapar.
    private func handle(_ key: CalcKey) {
        switch key {
        case .digit(let d): vm.inputDigit(d)
        case .decimal: vm.inputDecimal()
        case .plusMinus: vm.toggleSign()
        case .percent: vm.percent()
        case .clear: vm.clearAll()
        case .equals: vm.evaluateNow()
        case .op(let op): vm.setOperation(op)
        }
    }

    /// Metod görevi: Tuşun genişliğini hesaplar ("0" tuşu çift sütun).
    private func buttonWidth(for key: CalcKey) -> CGFloat {
        if case .digit(let d) = key, d == "0" {
            return (UIScreen.main.bounds.width - 12*5) / 2 + 12 // çift genişlik
        }
        return (UIScreen.main.bounds.width - 12*5) / 4
    }
}

/// Enum görevi: Ekrandaki tuş tiplerini temsil eder.
fileprivate enum CalcKey: Hashable {
    case digit(String)
    case decimal
    case plusMinus
    case percent
    case clear
    case equals
    case op(CalculatorOperation)

    /// Özellik görevi: Her tuş için benzersiz bir kimlik döndürür.
    var id: String {
        switch self {
        case .digit(let d): return "d_\(d)"
        case .decimal: return "decimal"
        case .plusMinus: return "plusMinus"
        case .percent: return "percent"
        case .clear: return "clear"
        case .equals: return "equals"
        case .op(let op): return "op_\(op.rawValue)"
        }
    }

    /// Özellik görevi: UI'da gösterilecek başlık/simgeyi döndürür.
    var title: String {
        switch self {
        case .digit(let d): return d
        case .decimal: return Locale.current.decimalSeparator ?? "."
        case .plusMinus: return "±"
        case .percent: return "%"
        case .clear: return "C"
        case .equals: return "="
        case .op(let op): return op.symbol
        }
    }
}

/// View görevi: Tek bir hesap makinesi tuşunu çizer.
fileprivate struct CalculatorButton: View {
    let key: CalcKey
    let action: () -> Void

    /// Görünüm görevi: Buton arayüzünü oluşturur.
    var body: some View {
        Button(action: action) {
            Text(key.title)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(tintColor)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityLabel(Text(accessibilityLabel))
    }

    /// Özellik görevi: Tuş tipine göre renk seçer.
    private var tintColor: Color {
        switch key {
        case .clear, .plusMinus, .percent:
            return .gray
        case .op, .equals:
            return .orange
        default:
            return .blue
        }
    }

    /// Özellik görevi: Erişilebilirlik etiketi üretir.
    private var accessibilityLabel: String {
        switch key {
        case .digit(let d): return NSLocalizedString("acc_digit", comment: "") + " " + d
        case .decimal: return NSLocalizedString("acc_decimal", comment: "")
        case .plusMinus: return NSLocalizedString("acc_plus_minus", comment: "")
        case .percent: return NSLocalizedString("acc_percent", comment: "")
        case .clear: return NSLocalizedString("acc_clear", comment: "")
        case .equals: return NSLocalizedString("acc_equals", comment: "")
        case .op(let op): return NSLocalizedString("acc_op", comment: "") + " " + op.symbol
        }
    }
}
