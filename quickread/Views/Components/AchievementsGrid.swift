import SwiftUI

struct AchievementsGrid: View {
    let achievements: [Achievement]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 15) {
            ForEach(achievements) { achievement in
                AchievementCard(achievement: achievement)
            }
        }
    }
}


struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        VStack {
            Image(systemName: achievement.isUnlocked ? "star.fill" : "star")
                .font(.title)
                .foregroundColor(achievement.isUnlocked ? .yellow : .gray)
            
            Text(achievement.title)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
} 
