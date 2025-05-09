import Foundation
import SwiftUI  // Color tipi için eklendi

struct WordExercise: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let difficulty: Difficulty
    let words: [String]
    let displayDuration: Double // saniye cinsinden
    
    enum Difficulty: String, CaseIterable {
        case beginner = "Başlangıç"
        case intermediate = "Orta"
        case advanced = "İleri"
        
        var color: Color {
            switch self {
            case .beginner: return .green
            case .intermediate: return .blue
            case .advanced: return .red
            }
        }
    }
} 