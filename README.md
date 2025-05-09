# QuickRead - Göz Sağlığı ve Okuma Hızı Uygulaması

QuickRead, göz sağlığını korumak ve okuma hızını artırmak için tasarlanmış bir iOS uygulamasıdır. Uygulama, göz egzersizleri ve okuma hızı testleri sunarak kullanıcıların göz sağlığını iyileştirmelerine ve okuma becerilerini geliştirmelerine yardımcı olur.

## Özellikler

### Göz Egzersizleri
- **Farklı Egzersiz Kategorileri**
  - Odaklanma Egzersizleri
  - Hareket Egzersizleri
  - Dinlenme Egzersizleri
- **Animasyonlu Egzersizler**
  - Dairesel hareketler
  - Sekiz şeklinde hareketler
  - Yakın-uzak odaklanma
- **Zorluk Seviyeleri**
  - Başlangıç
  - Orta
  - İleri
- **Zamanlayıcı ve İlerleme Takibi**
  - Egzersiz süresi göstergesi
  - İlerleme çemberi
  - Duraklat/Devam Et özelliği

### Okuma Hızı Testleri
- **Metin Seçimi**
  - Farklı zorluk seviyelerinde metinler
  - Çeşitli konularda içerikler
- **Hız Ölçümü**
  - Kelime/dakika hesaplama
  - Anlama seviyesi testi
- **İlerleme Takibi**
  - Kişisel istatistikler
  - Gelişim grafikleri

## Teknik Detaylar

### Kullanılan Teknolojiler
- SwiftUI
- Combine Framework
- Core Data (Yerel veri depolama)
- AVFoundation (Ses efektleri)

### Mimari
- MVVM (Model-View-ViewModel) mimarisi
- Protocol-oriented programming
- Dependency injection

### Dosya Yapısı
```
quickread/
├── Models/
│   ├── EyeExercise.swift
│   ├── ExerciseCategory.swift
│   ├── ExerciseType.swift
│   └── ExerciseDifficulty.swift
├── Views/
│   ├── ExerciseDetailView.swift
│   ├── ExerciseAnimationView.swift
│   └── ExerciseTimer.swift
├── ViewModels/
│   └── ExerciseViewModel.swift
└── Resources/
    └── Exercises.json
```

## Kurulum

1. Xcode 14.0 veya üstü gereklidir
2. iOS 15.0 veya üstü hedef platform
3. Projeyi klonlayın
4. `pod install` komutunu çalıştırın (CocoaPods kullanılıyorsa)
5. `.xcworkspace` dosyasını Xcode ile açın
6. Projeyi derleyin ve çalıştırın

## Geliştirme Durumu

Uygulama şu anda beta aşamasındadır. Aktif olarak geliştirilmektedir.

### Planlanan Özellikler
- [ ] Kullanıcı profili ve ayarlar
- [ ] Başarı sistemi
- [ ] Günlük hatırlatıcılar
- [ ] Detaylı istatistikler
- [ ] Sosyal özellikler
- [ ] Offline mod
- [ ] iCloud senkronizasyonu

## Katkıda Bulunma

1. Bu repository'yi fork edin
2. Feature branch'i oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## İletişim

Proje Sahibi - [@ferhatbozkurt](https://github.com/ferhatbozkurt)

Proje Linki: [https://github.com/ferhatbozkurt/quickread](https://github.com/ferhatbozkurt/quickread) 