import Foundation
import SwiftUI

// Question tanımını kaldırdık - Models/Question.swift'ten kullanacağız
public struct ComprehensionTest: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let description: String
    public let text: String
    public let questions: [BaseQuestion]
    public let category: Category
    public let difficulty: Difficulty
    public let requiredTestId: String?
    public let requiredScore: Int?
    
    public enum Category: String, Codable {
        case hikaye = "Hikaye"
        case bilim = "Bilim"
        case tarih = "Tarih"
        case makale = "Makale"
    }
    
    public enum Difficulty: String, Codable {
        case kolay = "Kolay"
        case orta = "Orta"
        case zor = "Zor"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case text
        case questions
        case category
        case difficulty
        case requiredTestId
        case requiredScore
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        text = try container.decode(String.self, forKey: .text)
        questions = try container.decode([BaseQuestion].self, forKey: .questions)
        category = try container.decode(Category.self, forKey: .category)
        difficulty = try container.decode(Difficulty.self, forKey: .difficulty)
        requiredTestId = try container.decodeIfPresent(String.self, forKey: .requiredTestId)
        requiredScore = try container.decodeIfPresent(Int.self, forKey: .requiredScore)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(text, forKey: .text)
        try container.encode(questions, forKey: .questions)
        try container.encode(category, forKey: .category)
        try container.encode(difficulty, forKey: .difficulty)
        try container.encodeIfPresent(requiredTestId, forKey: .requiredTestId)
        try container.encodeIfPresent(requiredScore, forKey: .requiredScore)
    }
    
    public init(title: String, 
               description: String, 
               text: String, 
               questions: [BaseQuestion], 
               category: Category, 
               difficulty: Difficulty, 
               requiredTestId: String? = nil, 
               requiredScore: Int? = nil,
               id: UUID = UUID()) {
        self.id = id
        self.title = title
        self.description = description
        self.text = text
        self.questions = questions
        self.category = category
        self.difficulty = difficulty
        self.requiredTestId = requiredTestId
        self.requiredScore = requiredScore
    }
}

// UI özellikleri için extension'lar
public extension ComprehensionTest.Category {
    var icon: String {
        switch self {
        case .hikaye: return "book"
        case .makale: return "doc.text"
        case .bilim: return "atom"
        case .tarih: return "clock"
        }
    }
}

public extension ComprehensionTest.Difficulty {
    var color: Color {
        switch self {
        case .kolay: return .green
        case .orta: return .blue
        case .zor: return .red
        }
    }
}

// Örnek veriler
public extension ComprehensionTest {
    static let tests: [ComprehensionTest] = [
        ComprehensionTest(
            title: "Milli Mücadele Dönemi",
            description: "Kurtuluş Savaşı ve Cumhuriyet'in kuruluş süreci",
            text: """
            Kurtuluş Savaşı, Türk milletinin var olma mücadelesinin en önemli dönüm noktalarından biridir...
            """,
            questions: [
                BaseQuestion(
                    text: "Kurtuluş Savaşı ne zaman başladı?",
                    options: ["15 Mayıs 1919", "19 Mayıs 1919", "23 Nisan 1920", "29 Ekim 1923"],
                    correctAnswer: 1,
                    explanation: "Kurtuluş Savaşı, Mustafa Kemal'in 19 Mayıs 1919'da Samsun'a çıkışıyla başladı."
                )
            ],
            category: .tarih,
            difficulty: .orta
        )
    ]
} 