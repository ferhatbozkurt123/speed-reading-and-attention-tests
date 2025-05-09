import Foundation

public struct UserProgress {
    public struct ExerciseProgress: Codable {
        public let date: Date
        public let duration: TimeInterval
        public let score: Int
        public let type: ExerciseType
        
        public init(date: Date, duration: TimeInterval, score: Int, type: ExerciseType) {
            self.date = date
            self.duration = duration
            self.score = score
            self.type = type
        }
    }
    
    public enum ExerciseType: String, Codable, CaseIterable {
        case wordRecognition = "Kelime Tanıma"
        case speedReading = "Hızlı Okuma"
        case eyeExercise = "Göz Egzersizi"
        case comprehension = "Anlama"
        
        public var icon: String {
            switch self {
            case .wordRecognition: return "text.magnifyingglass"
            case .speedReading: return "gauge"
            case .eyeExercise: return "eye"
            case .comprehension: return "book"
            }
        }
    }
}

// Progress işlemleri için extension
public extension UserProgress {
    static func saveProgress(_ progress: ExerciseProgress) {
        var savedProgress = getAllProgress()
        savedProgress.append(progress)
        
        if let encoded = try? JSONEncoder().encode(savedProgress) {
            UserDefaults.standard.set(encoded, forKey: "exerciseProgress")
        }
    }
    
    static func getAllProgress() -> [ExerciseProgress] {
        if let data = UserDefaults.standard.data(forKey: "exerciseProgress"),
           let decoded = try? JSONDecoder().decode([ExerciseProgress].self, from: data) {
            return decoded
        }
        return []
    }
    
    static func getProgress(for type: ExerciseType) -> [ExerciseProgress] {
        return getAllProgress().filter { $0.type == type }
    }
    
    static func getAverageScore(for type: ExerciseType) -> Int {
        let progress = getProgress(for: type)
        guard !progress.isEmpty else { return 0 }
        let totalScore = progress.reduce(0) { $0 + $1.score }
        return totalScore / progress.count
    }
    
    static func getTotalDuration(for type: ExerciseType) -> TimeInterval {
        return getProgress(for: type).reduce(0) { $0 + $1.duration }
    }
}