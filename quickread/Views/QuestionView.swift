import SwiftUI

struct QuestionView: View {
    let question: BaseQuestion
    let selectedAnswer: Int?
    let showExplanation: Bool
    let isCorrect: Bool?
    let onAnswerSelected: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(question.text)
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                Button(action: {
                    onAnswerSelected(index)
                }) {
                    HStack {
                        Text(option)
                            .foregroundColor(.primary)
                        Spacer()
                        if let selected = selectedAnswer, selected == index {
                            Image(systemName: isCorrect == nil ? "checkmark.circle.fill" :
                                    (isCorrect! ? "checkmark.circle.fill" : "xmark.circle.fill"))
                                .foregroundColor(isCorrect == nil ? .blue :
                                                (isCorrect! ? .green : .red))
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .disabled(selectedAnswer != nil)
            }
            
            if showExplanation {
                Text(question.explanation)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
} 