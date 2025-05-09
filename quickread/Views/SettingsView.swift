import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("textSize") private var textSize: Double = 16
    @AppStorage("readingSpeed") private var readingSpeed: Double = 250
    
    var body: some View {
        Form {
            Section(header: Text("Görünüm")) {
                Toggle("Karanlık Mod", isOn: $isDarkMode)
                
                VStack(alignment: .leading) {
                    Text("Yazı Boyutu")
                    Slider(value: $textSize, in: 12...24, step: 1) {
                        Text("Yazı Boyutu")
                    }
                    Text("\(Int(textSize)) pt")
                }
            }
            
            Section(header: Text("Okuma Ayarları")) {
                VStack(alignment: .leading) {
                    Text("Hedef Okuma Hızı")
                    Slider(value: $readingSpeed, in: 100...500, step: 10)
                    Text("\(Int(readingSpeed)) kelime/dakika")
                }
            }
            
            Section(header: Text("Uygulama Hakkında")) {
                Link("Gizlilik Politikası", destination: URL(string: "https://example.com/privacy")!)
                Link("Kullanım Koşulları", destination: URL(string: "https://example.com/terms")!)
                Text("Versiyon 1.0.0")
            }
        }
        .navigationTitle("Ayarlar")
    }
} 