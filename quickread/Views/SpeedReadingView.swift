import SwiftUI
import Foundation // Question için import ekleyelim

struct SpeedReadingView: View {
    let exercises = SpeedReadingExercise.exercises
    
    var body: some View {
        List(exercises) { exercise in
            NavigationLink(destination: SpeedReadingDetailView(exercise: exercise)) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(exercise.title)
                            .font(.headline)
                        Spacer()
                        Text(exercise.category.rawValue)
                            .font(.caption)
                            .padding(5)
                            .background(exercise.difficulty.color.opacity(0.2))
                            .cornerRadius(5)
                    }
                    
                    Text(exercise.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Tahmini okuma süresi: \(exercise.estimatedReadTime) sn")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Hız Okuma")
    }
}

#Preview {
    NavigationView {
        SpeedReadingView()
    }
} 
