import SwiftUI

struct ComprehensionView: View {
    @StateObject private var testManager = ComprehensionTestManager()
    
    var body: some View {
        List {
            ForEach(testManager.availableTests) { test in
                let isAvailable = testManager.isTestAvailable
                NavigationLink {
                    if isAvailable {
                        ComprehensionTestDetailView(test: test)
                    }
                } label: {
                    TestRowView(test: test, isAvailable: isAvailable)
                }
                .disabled(!isAvailable)
            }
        }
        .navigationTitle("Anlama Testleri")
    }
}

struct TestRowView: View {
    let test: ComprehensionTest
    let isAvailable: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: test.category.icon)
                    .foregroundColor(isAvailable ? .blue : .gray)
                
                Text(test.title)
                    .font(.headline)
                
                Spacer()
                
                Text(test.difficulty.rawValue)
                    .font(.caption)
                    .padding(5)
                    .background(test.difficulty.color.opacity(0.2))
                    .cornerRadius(5)
            }
            
            Text(test.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if !isAvailable {
                HStack {
                    Image(systemName: "lock.fill")
                    Text("Önceki testi tamamlayın")
                }
                .font(.caption)
                .foregroundColor(.orange)
            }
        }
        .padding(.vertical, 5)
        .opacity(isAvailable ? 1 : 0.6)
    }
} 
