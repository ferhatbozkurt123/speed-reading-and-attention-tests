import Foundation
import SwiftUI

public final class ComprehensionTestManager: ObservableObject {
    @Published public var tests: [ComprehensionTest] = []
    @Published public var availableTests: [ComprehensionTest] = []
    @Published public var isTestAvailable: Bool = false
    
    public static let shared = ComprehensionTestManager()
    
    public init() {
        loadTests()
        updateAvailableTests()
    }
    
    private func loadTests() {
        tests = ComprehensionTest.tests
    }
    
    private func updateAvailableTests() {
        availableTests = tests.filter { test in
            if let requiredTestId = test.requiredTestId,
               let requiredScore = test.requiredScore {
                return isTestCompleted(testId: requiredTestId, withScore: requiredScore)
            }
            return true
        }
        isTestAvailable = !availableTests.isEmpty
    }
    
    public func completeTest(test: ComprehensionTest, score: Int) {
        ProgressManager.shared.saveComprehensionResult(correctCount: score, totalCount: 100, duration: 0)
        updateAvailableTests()
    }
    
    private func isTestCompleted(testId: String, withScore requiredScore: Int) -> Bool {
        return true
    }
} 