import SwiftUI

public struct EyeExercise: Identifiable {
    public let id: String
    public let title: String
    public let description: String
    public let difficulty: Difficulty
    public let duration: Int
    public let type: ExerciseType
    public let instructions: [String]
    public let category: AnimationCategory
    
    public init(
        id: String,
        title: String,
        description: String,
        difficulty: Difficulty,
        duration: Int,
        type: ExerciseType,
        instructions: [String],
        category: AnimationCategory
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.difficulty = difficulty
        self.duration = duration
        self.type = type
        self.instructions = instructions
        self.category = category
    }
    
    public enum Difficulty {
        case beginner, intermediate, advanced, expert
        
        var badge: some View {
            Text(self.text)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(self.color.opacity(0.2))
                .foregroundColor(self.color)
                .cornerRadius(8)
        }
        
        var text: String {
            switch self {
            case .beginner: return "Başlangıç"
            case .intermediate: return "Orta"
            case .advanced: return "İleri"
            case .expert: return "Uzman"
            }
        }
        
        var color: Color {
            switch self {
            case .beginner: return .green
            case .intermediate: return .blue
            case .advanced: return .orange
            case .expert: return .red
            }
        }
    }
    
    public enum ExerciseType: String {
        case focusing = "Odaklama"
        case movement = "Hareket"
        case tracking = "Takip"
        case speed = "Hız"
        case coordination = "Koordinasyon"
        
        var icon: String {
            switch self {
            case .focusing: return "eye"
            case .movement: return "arrow.up.and.down.and.arrow.left.and.right"
            case .tracking: return "dot.circle.and.hand.point.up.left.fill"
            case .speed: return "speedometer"
            case .coordination: return "circle.grid.cross"
            }
        }
    }
    
    public enum AnimationCategory {
        case focus
        case horizontal
        case diagonal
        case depthFocus
        
        var icon: String {
            switch self {
            case .focus: return "eye.circle"
            case .horizontal: return "arrow.left.and.right"
            case .diagonal: return "arrow.up.right.and.arrow.down.left"
            case .depthFocus: return "arrow.left.and.right.circle"
            }
        }
    }
} 