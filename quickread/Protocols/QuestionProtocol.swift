import Foundation

// Base protocol for all question types
public protocol QuestionProtocol: Identifiable, Codable {
    var id: UUID { get }
    var text: String { get }
    var options: [String] { get }
    var correctAnswer: Int { get }
    var explanation: String { get }
}

// Base Question implementation
public struct BaseQuestion: QuestionProtocol, Codable {
    public let id: UUID
    public let text: String
    public let options: [String]
    public let correctAnswer: Int
    public let explanation: String
    
    public init(text: String, 
               options: [String], 
               correctAnswer: Int, 
               explanation: String,
               id: UUID = UUID()) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
        self.explanation = explanation
    }
    
    // Codable implementation
    private enum CodingKeys: String, CodingKey {
        case id, text, options, correctAnswer, explanation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        options = try container.decode([String].self, forKey: .options)
        correctAnswer = try container.decode(Int.self, forKey: .correctAnswer)
        explanation = try container.decode(String.self, forKey: .explanation)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(options, forKey: .options)
        try container.encode(correctAnswer, forKey: .correctAnswer)
        try container.encode(explanation, forKey: .explanation)
    }
}

// Type aliases for different contexts
public extension ComprehensionTest {
    typealias Question = BaseQuestion
}

public extension SpeedReadingExercise {
    typealias Question = BaseQuestion
} 