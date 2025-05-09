import SwiftUI

struct WeeklyProgressChart: View {
    let data: [Double]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Haftalık İlerleme")
                .font(.headline)
            
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(data.indices, id: \.self) { index in
                    VStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 30, height: data[index] * 100)
                        
                        Text("G\(index + 1)")
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
} 