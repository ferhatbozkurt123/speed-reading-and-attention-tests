import SwiftUI

public struct ProgressView: View {
    @StateObject private var progressManager = ProgressManager.shared
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Toplam İstatistikler
                StatisticsCard(
                    title: "Toplam Okuma Süresi",
                    value: "\(progressManager.totalReadingTime) dakika",
                    icon: "clock"
                )
                
                StatisticsCard(
                    title: "Ortalama Okuma Hızı",
                    value: "\(progressManager.averageWordsPerMinute) KDK",
                    icon: "gauge"
                )
                
                StatisticsCard(
                    title: "Tamamlanan Egzersizler",
                    value: "\(progressManager.completedExercises)",
                    icon: "checkmark.circle"
                )
                
                // Seviye Göstergesi
                LevelProgressCard(
                    title: "Seviye \(progressManager.currentLevel)",
                    progress: Double(progressManager.experience) / Double(progressManager.nextLevelExperience),
                    color: .blue
                )
                
                // Kategori İlerlemeleri
                VStack(alignment: .leading, spacing: 15) {
                    Text("Kategori İlerlemeleri")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(UserProgress.ExerciseType.allCases, id: \.self) { type in
                        HStack {
                            Image(systemName: type.icon)
                                .foregroundColor(.blue)
                            Text(type.rawValue)
                                .font(.headline)
                            Spacer()
                            Text("85%")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            ProgressBar(value: 0.85)
                                .frame(width: 100)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
                
                // Başarımlar
                AchievementsGrid(achievements: progressManager.achievements)
                
                // Haftalık İlerleme Grafiği
                WeeklyProgressChart(data: progressManager.weeklyProgress)
                
                StatItem(
                    title: "Tamamlanan",
                    value: "\(progressManager.completedTests)",
                    icon: "checkmark.circle.fill"
                )
            }
            .padding()
        }
        .navigationTitle("İlerleme")
    }
}

struct StatisticsCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ProgressBar: View {
    let value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: 8)
                    .foregroundColor(.blue)
            }
            .cornerRadius(4)
        }
    }
} 
