import SwiftUI
import Foundation

struct WordRecognitionView: View {
    let exercises = [
        WordExercise(
            title: "Temel Kelimeler",
            description: "Günlük hayatta sık kullanılan kelimeler",
            difficulty: .beginner,
            words: ["ev", "araba", "kitap", "kalem", "masa", "sandalye", "telefon", "bilgisayar"],
            displayDuration: 0.5
        ),
        WordExercise(
            title: "Orta Seviye",
            description: "Daha uzun ve karmaşık kelimeler",
            difficulty: .intermediate,
            words: ["teknoloji", "matematik", "psikoloji", "ekonomi", "mühendislik", "astronomi"],
            displayDuration: 0.4
        ),
        WordExercise(
            title: "İleri Seviye",
            description: "Uzun ve nadir kullanılan kelimeler",
            difficulty: .advanced,
            words: ["epistemoloji", "paleontoloji", "biyoteknoloji", "nörofizyoloji"],
            displayDuration: 0.3
        )
    ]
    
    var body: some View {
        List(exercises) { exercise in
            NavigationLink(destination: WordExerciseDetailView(exercise: exercise)) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(exercise.title)
                            .font(.headline)
                        Spacer()
                        Text(exercise.difficulty.rawValue)
                            .font(.caption)
                            .padding(5)
                            .background(exercise.difficulty.color.opacity(0.2))
                            .cornerRadius(5)
                    }
                    
                    Text(exercise.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Gösterim Süresi: \(String(format: "%.1f", exercise.displayDuration)) sn")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Kelime Tanıma")
    }
} 