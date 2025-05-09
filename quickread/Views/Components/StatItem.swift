import SwiftUI

struct StatItem: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
            
            Text(value)
                .font(.title2)
                .bold()
            
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
} 