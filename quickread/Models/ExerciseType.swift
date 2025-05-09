import Foundation

enum ExerciseType: String, CaseIterable {
    case wordRecognition = "Kelime Tanıma"
    case speedReading = "Hızlı Okuma"
    case eyeExercise = "Göz Egzersizi"
    case comprehension = "Anlama"
    
    var icon: String {
        switch self {
        case .wordRecognition: return "text.magnifyingglass"
        case .speedReading: return "gauge"
        case .eyeExercise: return "eye"
        case .comprehension: return "book"
        }
    }
} 