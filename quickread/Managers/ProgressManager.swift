import SwiftUI

public final class ProgressManager: ObservableObject {
    public static let shared = ProgressManager()
    
    @Published public var totalReadingTime: Int = 0
    @Published public var averageWordsPerMinute: Int = 0
    @Published public var completedExercises: Int = 0
    @Published public var currentLevel: Int = 1
    @Published public var experience: Double = 0
    @Published public var nextLevelExperience: Double = 100
    @Published public var weeklyProgress: [Double] = [0.3, 0.5, 0.7, 0.4, 0.6, 0.8, 0.5]
    @Published public var achievements: [Achievement] = Achievement.examples
    @Published public var completedTests: Int = 0
    
    private init() {
        loadProgress()
        loadAchievements()
    }
    
    private func loadProgress() {
        totalReadingTime = UserDefaults.standard.integer(forKey: "totalReadingTime")
        averageWordsPerMinute = UserDefaults.standard.integer(forKey: "averageWPM")
        completedExercises = UserDefaults.standard.integer(forKey: "completedExercises")
        currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
        experience = UserDefaults.standard.double(forKey: "experience")
        completedTests = UserDefaults.standard.integer(forKey: "completedTests")
    }
    
    private func loadAchievements() {
        achievements = Achievement.examples
    }
    
    public func updateProgress(readingTime: Int, wordsPerMinute: Int) {
        totalReadingTime += readingTime
        let totalExercises = completedExercises + 1
        averageWordsPerMinute = ((averageWordsPerMinute * completedExercises) + wordsPerMinute) / totalExercises
        completedExercises += 1
        addExperience(points: Double(wordsPerMinute) / 10)
        checkAchievements()
        saveProgress()
    }
    
    private func checkAchievements() {
        for (index, achievement) in achievements.enumerated() {
            var shouldUnlock = false
            
            switch achievement.type {
            case .speedReading:
                shouldUnlock = averageWordsPerMinute >= achievement.requirement
            case .comprehension:
                shouldUnlock = completedTests >= achievement.requirement
            case .wordRecognition:
                shouldUnlock = completedExercises >= achievement.requirement
            case .eyeExercise:
                shouldUnlock = totalReadingTime >= achievement.requirement
            }
            
            if shouldUnlock && !achievement.isUnlocked {
                achievements[index] = Achievement(
                    id: achievement.id,
                    title: achievement.title,
                    description: achievement.description,
                    type: achievement.type,
                    requirement: achievement.requirement,
                    isUnlocked: true
                )
            }
        }
    }
    
    private func saveProgress() {
        UserDefaults.standard.set(totalReadingTime, forKey: "totalReadingTime")
        UserDefaults.standard.set(averageWordsPerMinute, forKey: "averageWPM")
        UserDefaults.standard.set(completedExercises, forKey: "completedExercises")
        UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
        UserDefaults.standard.set(experience, forKey: "experience")
        UserDefaults.standard.set(completedTests, forKey: "completedTests")
    }
    
    private func addExperience(points: Double) {
        experience += points
        while experience >= nextLevelExperience {
            currentLevel += 1
            experience -= nextLevelExperience
            nextLevelExperience *= 1.5
        }
    }
    
    public func saveEyeExerciseResult(duration: TimeInterval) {
        let progress = UserProgress.ExerciseProgress(
            date: Date(),
            duration: duration,
            score: 100,
            type: .eyeExercise
        )
        UserProgress.saveProgress(progress)
    }
    
    public func saveWordRecognitionResult(correctCount: Int, totalCount: Int, duration: TimeInterval) {
        let score = Int((Double(correctCount) / Double(totalCount)) * 100)
        let progress = UserProgress.ExerciseProgress(
            date: Date(),
            duration: duration,
            score: score,
            type: .wordRecognition
        )
        UserProgress.saveProgress(progress)
    }
    
    public func saveSpeedReadingResult(wordsPerMinute: Int, comprehensionScore: Int, duration: TimeInterval) {
        let score = (wordsPerMinute / 4) + comprehensionScore
        let progress = UserProgress.ExerciseProgress(
            date: Date(),
            duration: duration,
            score: min(score, 100),
            type: .speedReading
        )
        UserProgress.saveProgress(progress)
    }
    
    public func saveComprehensionResult(correctCount: Int, totalCount: Int, duration: TimeInterval) {
        let score = Int((Double(correctCount) / Double(totalCount)) * 100)
        let progress = UserProgress.ExerciseProgress(
            date: Date(),
            duration: duration,
            score: score,
            type: .comprehension
        )
        UserProgress.saveProgress(progress)
    }
} 
