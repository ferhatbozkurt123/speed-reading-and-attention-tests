import SwiftUI
import Foundation

struct WordExerciseDetailView: View {
    let exercise: WordExercise
    @State private var currentWord = ""
    @State private var isExerciseActive = false
    @State private var wordIndex = 0
    @State private var showWord = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            Text(exercise.title)
                .font(.title)
                .bold()
            
            if isExerciseActive {
                Text(showWord ? currentWord : "")
                    .font(.system(size: 40, weight: .bold))
                    .frame(height: 100)
                    .onReceive(timer) { _ in
                        if isExerciseActive {
                            updateWord()
                        }
                    }
            } else {
                Text("Hazır olduğunuzda başlayın")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                isExerciseActive.toggle()
                if isExerciseActive {
                    wordIndex = 0
                    showWord = true
                    currentWord = exercise.words[wordIndex]
                }
            }) {
                Text(isExerciseActive ? "Durdur" : "Başla")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(isExerciseActive ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func updateWord() {
        if !showWord {
            showWord = true
            currentWord = exercise.words[wordIndex]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + exercise.displayDuration) {
                if isExerciseActive {
                    showWord = false
                    wordIndex = (wordIndex + 1) % exercise.words.count
                }
            }
        }
    }
} 