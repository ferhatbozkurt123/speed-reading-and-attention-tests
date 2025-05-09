import Foundation

public struct Achievement: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let description: String
    public let type: AchievementType
    public let requirement: Int
    public let isUnlocked: Bool
    
    public enum AchievementType: String, Codable {
        case speedReading = "Hızlı Okuma"
        case comprehension = "Anlama"
        case wordRecognition = "Kelime Tanıma"
        case eyeExercise = "Göz Egzersizi"
        
        public var icon: String {
            switch self {
            case .speedReading: return "gauge"
            case .comprehension: return "book"
            case .wordRecognition: return "text.magnifyingglass"
            case .eyeExercise: return "eye"
            }
        }
    }
    
    public init(id: UUID = UUID(),
               title: String,
               description: String,
               type: AchievementType,
               requirement: Int,
               isUnlocked: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.requirement = requirement
        self.isUnlocked = isUnlocked
    }
}

// Örnek başarımlar
public extension Achievement {
    static let examples: [Achievement] = [
        Achievement(
            title: "Hızlı Okuyucu",
            description: "500 KDK hızına ulaş",
            type: .speedReading,
            requirement: 500
        ),
        Achievement(
            title: "Anlama Ustası",
            description: "10 testi %90 üzeri başarıyla tamamla",
            type: .comprehension,
            requirement: 10
        ),
        Achievement(
            title: "Kelime Ustası",
            description: "100 kelime tanıma egzersizi tamamla",
            type: .wordRecognition,
            requirement: 100
        ),
        Achievement(
            title: "Göz Egzersizi Uzmanı",
            description: "Toplam 1 saat göz egzersizi yap",
            type: .eyeExercise,
            requirement: 3600 // 1 saat = 3600 saniye
        )
    ]
} 