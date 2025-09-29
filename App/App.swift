// =======================================================
// Dosya: /App/App.swift
// Sayfa görevi: SwiftUI uygulama giriş noktası ve root görünüm oluşturma.
// Katman: App
// =======================================================

import SwiftUI
import Domain

@main
struct CalculatorCleanMVVMApp: App {
    private let container = AppContainer.live()

    /// Görünüm görevi: Uygulama penceresi ve kök görünümü kurar.
    var body: some Scene {
        WindowGroup {
            RootView(container: container)
        }
    }
}

/// View görevi: Sekmeli kök görünümü sağlar (Hesap + Geçmiş).
struct RootView: View {
    let container: AppContainer
    @StateObject private var vm: CalculatorViewModel

    /// Init görevi: ViewModel'i DI Container üzerinden oluşturarak bağlar.
    init(container: AppContainer) {
        self.container = container
        _vm = StateObject(wrappedValue: CalculatorViewModel(
            evaluate: container.evaluateUseCase,
            getHistory: container.getHistoryUseCase,
            clearHistoryUseCase: container.clearHistoryUseCase
        ))
    }

    /// Görünüm görevi: Sekmeli yapıyı oluşturur.
    var body: some View {
        NavigationStack {
            TabView {
                CalculatorView(vm: vm)
                    .tabItem { Label(NSLocalizedString("tab_calculator", comment: ""), systemImage: "plus.slash.minus") }
                HistoryView(fetch: { vm.history() }, clear: { vm.clearHistory() })
                    .tabItem { Label(NSLocalizedString("tab_history", comment: ""), systemImage: "clock") }
            }
        }
    }
}
