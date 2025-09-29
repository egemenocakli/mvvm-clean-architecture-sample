# CalculatorCleanMVVM (SwiftUI • MVVM + Clean Architecture)

Bu proje, **SwiftUI** ile yazılmış basit bir hesap makinesini **MVVM + Clean Architecture** prensipleriyle örnekler.
Tamamen modülerdir: **Domain**, **Data**, **Presentation**, **App**, **Shared**, **Resources** katmanları ayrıdır.

## Özellikler
- Dört işlem: Toplama, Çıkarma, Çarpma, Bölme
- Yüzde (%), işaret değiştirme (±), temizleme (C), ondalık giriş
- Hesap geçmişi (UserDefaults ile kalıcı)
- Türkçe / İngilizce yerelleştirme
- Proje dosyası için `XcodeGen` tanımı (`project.yml`): `brew install xcodegen` ardından `xcodegen generate`

## Kurulum
1. `brew install xcodegen` (yüklü değilse)
2. Proje klasöründe `xcodegen generate` çalıştır.
3. Oluşan `.xcodeproj` dosyasını Xcode ile aç.
4. iOS 16.0+ simülatörde çalıştır.

> Alternatif: Xcode’da manuel bir SwiftUI iOS App oluşturup bu klasördeki dosyaları uygun klasörlere kopyalayabilirsin.

## Katmanlar
- **Domain**: İş kuralları, entity’ler, use case’ler, repository protokolleri (UI bağımsız)
- **Data**: Domain repository’lerinin gerçek implementasyonları (UserDefaults, network vb.)
- **Presentation**: SwiftUI View ve ViewModel’ler (sadece UseCase’leri görür)
- **App**: DI/CompositionRoot, App giriş noktası
- **Shared**: Ortak sabitler, yardımcılar
- **Resources**: Yerelleştirme dosyaları, Asset’ler

## Test
- `Tests` klasöründe temel Unit Test örnekleri mevcuttur (UseCase + ViewModel).

