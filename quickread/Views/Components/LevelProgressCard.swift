import SwiftUI

public struct LevelProgressCard: View {
    private let title: String
    private let progress: Double
    private let color: Color
    
    public init(title: String, progress: Double, color: Color) {
        self.title = title
        self.progress = progress
        self.color = color
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 8)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * CGFloat(progress), height: 8)
                        .foregroundColor(color)
                }
                .cornerRadius(4)
            }
            .frame(height: 8)
            
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct LevelProgressCard_Previews: PreviewProvider {
    static var previews: some View {
        LevelProgressCard(
            title: "Seviye 1",
            progress: 0.75,
            color: .blue
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
} 