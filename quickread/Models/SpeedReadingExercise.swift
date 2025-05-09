import Foundation
import SwiftUI

// Question'ı Models/Question.swift'ten kullanıyoruz
public struct SpeedReadingExercise: Identifiable {
    public let id: UUID
    public let title: String
    public let description: String
    public let text: String
    public let difficulty: Difficulty
    public let estimatedReadTime: Int
    public let questions: [Question]
    public let category: Category
    
    public enum Category: String {
        case story = "Hikaye"
        case science = "Bilim"
        case history = "Tarih"
        case literature = "Edebiyat"
        case technology = "Teknoloji"
    }
    
    public enum Difficulty: String {
        case beginner = "Başlangıç"
        case intermediate = "Orta"
        case advanced = "İleri"
    }
    
    public init(id: UUID = UUID(),
               title: String,
               description: String,
               text: String,
               difficulty: Difficulty,
               estimatedReadTime: Int,
               questions: [Question],
               category: Category) {
        self.id = id
        self.title = title
        self.description = description
        self.text = text
        self.difficulty = difficulty
        self.estimatedReadTime = estimatedReadTime
        self.questions = questions
        self.category = category
    }
}

// UI özellikleri için extension'lar
extension SpeedReadingExercise.Category {
    var icon: String {
        switch self {
        case .story: return "book"
        case .science: return "atom"
        case .history: return "clock"
        case .literature: return "text.book.closed"
        case .technology: return "cpu"
        }
    }
}

extension SpeedReadingExercise.Difficulty {
    var color: Color {
        switch self {
        case .beginner: return .green
        case .intermediate: return .blue
        case .advanced: return .red
        }
    }
    
    var wordsPerMinute: Int {
        switch self {
        case .beginner: return 150
        case .intermediate: return 250
        case .advanced: return 400
        }
    }
}

// Örnek veriler
extension SpeedReadingExercise {
    public static let exercises: [SpeedReadingExercise] = [
        SpeedReadingExercise(
            id: UUID(),
            title: "Temel Okuma",
            description: "Kısa ve basit bir metin ile başlayın",
            text: "Okuma, bilgi edinmenin en temel yollarından biridir...",
            difficulty: .beginner,
            estimatedReadTime: 30,
            questions: [
                Question(
                    text: "Metne göre iyi bir okuyucu olmak neyin anahtarıdır?",
                    options: ["Başarının", "Hayat boyu öğrenmenin", "Hızlı okumanın", "Bilgi edinmenin"],
                    correctAnswer: 1,
                    explanation: "Metin, iyi bir okuyucu olmanın hayat boyu öğrenmenin anahtarı olduğunu belirtmektedir."
                )
            ],
            category: .story
        )
    ]
} 