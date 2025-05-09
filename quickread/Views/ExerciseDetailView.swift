import SwiftUI

struct ExerciseDetailView: View {
    let exercise: EyeExercise
    @Environment(\.dismiss) private var dismiss
    @StateObject private var timer = ExerciseTimer()
    @State private var showInstructions = true
    @State private var currentInstruction = 0
    @State private var isAnimating = false
    @State private var instructionTimer: Timer? = nil
    @State private var lastInstructionChange = Date()
    let instructionDuration: TimeInterval = 5 // Her talimat 5 saniye gösterilecek
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                if showInstructions {
                    instructionsView
                } else {
                    exerciseView(geometry: geometry)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    timer.stop()
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private var instructionsView: some View {
        VStack(spacing: 25) {
            Text(exercise.title)
                .font(.title2.bold())
            
            Text(exercise.description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Talimatlar")
                    .font(.headline)
                
                ForEach(exercise.instructions.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(index + 1).")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                        Text(exercise.instructions[index])
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            VStack(spacing: 10) {
                Text("Süre: \(exercise.duration) saniye")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button(action: {
                    withAnimation {
                        showInstructions = false
                        isAnimating = true
                        timer.start(duration: exercise.duration)
                    }
                }) {
                    Text("Egzersizi Başlat")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
        }
    }
    
    private func exerciseView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 30) {
            // Timer ve İlerleme
            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 15)
                
                Circle()
                    .trim(from: 0, to: timer.progress)
                    .stroke(Color.blue, lineWidth: 15)
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(timer.timeRemaining)")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                    Text("saniye")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: min(geometry.size.width * 0.4, 200))
            
            // Animasyon Alanı
            ZStack {
                Color(.systemGray6)
                    .cornerRadius(15)
                
                if isAnimating {
                    ExerciseAnimationView(exercise: exercise)
                }
            }
            .frame(height: geometry.size.height * 0.5)
            
            // Mevcut Talimat
            Text(exercise.instructions[currentInstruction])
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .transition(.opacity)
            
            // Kontrol Butonları
            HStack(spacing: 30) {
                if timer.isRunning {
                    Button(action: { timer.pause() }) {
                        controlButton(icon: "pause.circle.fill", text: "Duraklat")
                    }
                } else if timer.timeRemaining < exercise.duration {
                    Button(action: { timer.resume() }) {
                        controlButton(icon: "play.circle.fill", text: "Devam Et")
                    }
                }
                
                Button(action: {
                    timer.stop()
                    dismiss()
                }) {
                    controlButton(icon: "stop.circle.fill", text: "Bitir")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            // Talimat değişim zamanlayıcısını başlat
            instructionTimer = Timer.scheduledTimer(withTimeInterval: instructionDuration, repeats: true) { _ in
                withAnimation(.easeInOut) {
                    currentInstruction = (currentInstruction + 1) % exercise.instructions.count
                }
            }
        }
        .onDisappear {
            // View kapandığında timer'ı temizle
            instructionTimer?.invalidate()
            instructionTimer = nil
        }
        .onReceive(timer.$isFinished) { isFinished in
            if isFinished {
                withAnimation {
                    isAnimating = false
                }
                instructionTimer?.invalidate() // Timer'ı durdur
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
        }
    }
    
    private func controlButton(icon: String, text: String) -> some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.title)
            Text(text)
                .font(.caption)
        }
    }
}

class ExerciseTimer: ObservableObject {
    @Published var timeRemaining = 0
    @Published var progress: Double = 0
    @Published var isRunning = false
    @Published var isFinished = false
    
    private var timer: Timer?
    private var totalDuration: Int = 0
    
    func start(duration: Int) {
        totalDuration = duration
        timeRemaining = duration
        progress = 1.0
        isRunning = true
        isFinished = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func updateTimer() {
        guard timeRemaining > 0 else {
            stop()
            return
        }
        
        timeRemaining -= 1
        progress = Double(timeRemaining) / Double(totalDuration)
        
        if timeRemaining == 0 {
            isFinished = true
        }
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func resume() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isFinished = true
    }
} 