import SwiftUI

struct ComprehensionTestDetailView: View {
    let test: ComprehensionTest
    @StateObject private var testManager = ComprehensionTestManager.shared
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswers: [Int?] = []
    @State private var showResults = false
    @State private var score = 0
    @State private var showExplanation: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Test başlığı ve açıklaması
                Text(test.title)
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                Text(test.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Test metni
                Text(test.text)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                
                if !showResults {
                    // Soru görünümü
                    QuestionView(
                        question: test.questions[currentQuestionIndex],
                        selectedAnswer: selectedAnswers.count > currentQuestionIndex ? selectedAnswers[currentQuestionIndex] : nil,
                        showExplanation: showExplanation == currentQuestionIndex,
                        isCorrect: showResults ? (selectedAnswers[currentQuestionIndex] == test.questions[currentQuestionIndex].correctAnswer) : nil,
                        onAnswerSelected: { answer in
                            if selectedAnswers.count > currentQuestionIndex {
                                selectedAnswers[currentQuestionIndex] = answer
                            } else {
                                selectedAnswers.append(answer)
                            }
                        }
                    )
                    
                    // İlerleme butonları
                    HStack {
                        if currentQuestionIndex > 0 {
                            Button("Önceki") {
                                currentQuestionIndex -= 1
                            }
                        }
                        
                        Spacer()
                        
                        if currentQuestionIndex < test.questions.count - 1 {
                            Button("Sonraki") {
                                currentQuestionIndex += 1
                            }
                        } else {
                            Button("Testi Bitir") {
                                calculateScore()
                                showResults = true
                            }
                            .disabled(selectedAnswers.count < test.questions.count)
                        }
                    }
                    .padding()
                } else {
                    // Sonuç görünümü
                    TestResultView(
                        score: score,
                        questions: test.questions,
                        selectedAnswers: selectedAnswers
                    )
                }
            }
            .padding()
        }
        .navigationBarTitle("Test", displayMode: .inline)
    }
    
    private func calculateScore() {
        var correctAnswers = 0
        for (index, answer) in selectedAnswers.enumerated() {
            if let answer = answer,
               answer == test.questions[index].correctAnswer {
                correctAnswers += 1
            }
        }
        score = Int((Double(correctAnswers) / Double(test.questions.count)) * 100)
        testManager.completeTest(test: test, score: score)
    }
} 
