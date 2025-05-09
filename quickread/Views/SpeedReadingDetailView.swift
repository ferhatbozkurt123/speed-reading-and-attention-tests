import SwiftUI
import Foundation

struct SpeedReadingDetailView: View {
    let exercise: SpeedReadingExercise
    @StateObject private var progressManager = ProgressManager.shared
    @State private var showText = false
    @State private var startTime: Date?
    @State private var endTime: Date?
    @State private var showQuestions = false
    @State private var selectedAnswers: [Int?] = []
    @State private var showResults = false
    @State private var showExplanation: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if !showText {
                    startView
                } else if !showQuestions {
                    textView
                } else {
                    questionsView
                }
            }
            .padding()
        }
        .navigationTitle(exercise.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var startView: some View {
        VStack(spacing: 20) {
            Text("Hazır olduğunuzda başlayın")
                .font(.title)
                .multilineTextAlignment(.center)
            
            Text("Tavsiye edilen okuma hızı: \(exercise.difficulty.wordsPerMinute) KDK")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: {
                startTime = Date()
                showText = true
            }) {
                Text("Başla")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    private var textView: some View {
        VStack(spacing: 20) {
            Text(exercise.text)
                .font(.body)
                .lineSpacing(8)
            
            Button(action: {
                endTime = Date()
                showQuestions = true
            }) {
                Text("Okumayı Bitir")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    private var questionsView: some View {
        VStack(spacing: 20) {
            ForEach(Array(exercise.questions.enumerated()), id: \.offset) { index, question in
                QuestionView(
                    question: question,
                    selectedAnswer: selectedAnswers.indices.contains(index) ? selectedAnswers[index] : nil,
                    showExplanation: showExplanation == index,
                    isCorrect: showResults ? (selectedAnswers[index] == question.correctAnswer) : nil,
                    onAnswerSelected: { answer in
                        if selectedAnswers.count > index {
                            selectedAnswers[index] = answer
                        } else {
                            selectedAnswers.append(answer)
                        }
                    }
                )
            }
            
            if selectedAnswers.count == exercise.questions.count {
                Button(action: {
                    if !showResults {
                        showResults = true
                        saveProgress()
                    }
                }) {
                    Text(showResults ? "Sonuçlar" : "Testi Bitir")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            if showResults {
                resultsView
            }
        }
    }
    
    private var resultsView: some View {
        VStack(spacing: 15) {
            Text("Sonuçlar")
                .font(.title)
            
            if let startTime = startTime, let endTime = endTime {
                let duration = endTime.timeIntervalSince(startTime)
                let wordsPerMinute = Int(Double(exercise.text.split(separator: " ").count) / duration * 60)
                
                Text("Okuma Hızı: \(wordsPerMinute) KDK")
                    .font(.headline)
                
                Text("Süre: \(Int(duration)) saniye")
                    .font(.subheadline)
                
                Text("Anlama Puanı: \(calculateScore())%")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    private func calculateScore() -> Int {
        var correctCount = 0
        for (index, answer) in selectedAnswers.enumerated() {
            if let answer = answer, answer == exercise.questions[index].correctAnswer {
                correctCount += 1
            }
        }
        return Int((Double(correctCount) / Double(exercise.questions.count)) * 100)
    }
    
    private func saveProgress() {
        guard let startTime = startTime, let endTime = endTime else { return }
        let duration = endTime.timeIntervalSince(startTime)
        let wordsPerMinute = Int(Double(exercise.text.split(separator: " ").count) / duration * 60)
        let comprehensionScore = calculateScore()
        
        progressManager.saveSpeedReadingResult(
            wordsPerMinute: wordsPerMinute,
            comprehensionScore: comprehensionScore,
            duration: duration
        )
    }
}

struct QuestionView1: View {
    let question: SpeedReadingExercise.Question
    let selectedAnswer: Int?
    let showExplanation: Bool
    let isCorrect: Bool?
    let onAnswerSelected: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.text)
                .font(.headline)
            
            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                Button(action: {
                    onAnswerSelected(index)
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedAnswer == index {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectedAnswer == index ? Color.blue : Color.gray, lineWidth: 1)
                    )
                }
                .foregroundColor(.primary)
            }
            
            if showExplanation {
                Text(question.explanation)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let isCorrect = isCorrect {
                Text(isCorrect ? "Doğru" : "Yanlış")
                    .font(.caption)
                    .foregroundColor(isCorrect ? .green : .red)
            }
        }
        .padding(.vertical)
    }
} 
