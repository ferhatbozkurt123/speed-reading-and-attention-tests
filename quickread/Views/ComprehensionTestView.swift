import SwiftUI

struct ComprehensionTestView: View {
    @StateObject private var testManager = ComprehensionTestManager.shared
    
    var body: some View {
        List(testManager.tests) { test in
            NavigationLink(destination: ComprehensionTestDetailView(test: test)) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(test.title)
                            .font(.headline)
                        Spacer()
                        Text(test.category.rawValue)
                            .font(.caption)
                            .padding(5)
                            .background(test.difficulty.color.opacity(0.2))
                            .cornerRadius(5)
                    }
                    
                    Text(test.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Anlama Testleri")
    }
}

struct TestResultView: View {
    let score: Int
    let questions: [ComprehensionTest.Question]
    let selectedAnswers: [Int?]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test Tamamlandı!")
                .font(.title)
                .bold()
            
            Text("Puanınız: \(score)")
                .font(.title2)
                .foregroundColor(score >= 70 ? .green : .red)
            
            ForEach(questions.indices, id: \.self) { index in
                QuestionResultView(
                    question: questions[index],
                    selectedAnswer: selectedAnswers[index],
                    isCorrect: selectedAnswers[index] == questions[index].correctAnswer
                )
            }
        }
    }
}

struct QuestionResultView: View {
    let question: ComprehensionTest.Question
    let selectedAnswer: Int?
    let isCorrect: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.text)
                .font(.headline)
            
            if let selectedAnswer = selectedAnswer {
                Text("Cevabınız: \(question.options[selectedAnswer])")
                    .foregroundColor(isCorrect ? .green : .red)
            }
            
            Text("Doğru cevap: \(question.options[question.correctAnswer])")
                .foregroundColor(.green)
            
            Text(question.explanation)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
} 
