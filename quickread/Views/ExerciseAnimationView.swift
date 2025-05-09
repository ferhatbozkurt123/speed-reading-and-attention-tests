import SwiftUI
import Foundation

struct ExerciseAnimationView: View {
    let exercise: EyeExercise
    @State private var position = CGPoint(x: 0.5, y: 0.5)
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var currentStep = 0
    @State private var angle: Double = 0
    
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Ana takip noktası
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .position(
                        x: position.x * geometry.size.width,
                        y: position.y * geometry.size.height
                    )
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                // Yardımcı çizgiler (gerektiğinde)
                if exercise.type == .movement {
                    exerciseGuideLines
                }
            }
            .onAppear {
                startAnimation()
            }
            .onReceive(timer) { _ in
                updateCircularMovement()
            }
        }
    }
    
    private var exerciseGuideLines: some View {
        ZStack {
            switch exercise.category {
            case .focus:
                // Odak noktaları için referans daireleri
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 100, height: 100)
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 200, height: 200)
                
            case .horizontal:
                // Yatay hareket için rehber çizgi
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 2)
                
            case .diagonal:
                // Çapraz hareket için rehber çizgiler
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
                }
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                
            case .depthFocus:
                // Derinlik algısı için iç içe daireler
                ForEach(0..<3) { index in
                    Circle()
                        .stroke(Color.gray.opacity(0.2))
                        .frame(width: CGFloat(100 + (index * 50)))
                }
            }
        }
    }
    
    private func startAnimation() {
        switch exercise.type {
        case .focusing:
            animateFocusing()
        case .movement:
            animateMovement()
        case .tracking:
            animateTracking()
        case .speed:
            animateSpeed()
        case .coordination:
            animateCoordination()
        }
    }
    
    private func animateFocusing() {
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            scale = exercise.category == .depthFocus ? 2.0 : 1.5
            opacity = 0.7
        }
    }
    
    private func animateMovement() {
        switch exercise.category {
        case .horizontal:
            // Yatay 8 hareketi
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false)) {
                position = CGPoint(x: 0.9, y: 0.5)
            }
            
        case .diagonal:
            // Çapraz hareket
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                position = CGPoint(x: 0.9, y: 0.9)
            }
            
        case .focus:
            // Dairesel hareket
            animateCircularMovement()
            
        case .depthFocus:
            // Yakınlaşma-uzaklaşma
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                scale = 2.0
                opacity = 0.5
            }
        }
    }
    
    private func animateCircularMovement() {
        angle = 0
    }
    
    private func animateTracking() {
        let points: [CGPoint] = [
            CGPoint(x: 0.1, y: 0.1),
            CGPoint(x: 0.9, y: 0.1),
            CGPoint(x: 0.9, y: 0.9),
            CGPoint(x: 0.1, y: 0.9)
        ]
        
        func moveToNextPoint() {
            currentStep = (currentStep + 1) % points.count
            withAnimation(.easeInOut(duration: 1)) {
                position = points[currentStep]
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                moveToNextPoint()
            }
        }
        
        moveToNextPoint()
    }
    
    private func animateSpeed() {
        let duration = exercise.difficulty == .expert ? 0.5 : 1.0
        withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
            position = CGPoint(x: 0.9, y: position.y)
        }
    }
    
    private func animateCoordination() {
        animateComplexPattern()
    }
    
    private func animateComplexPattern() {
        let points: [CGPoint] = [
            CGPoint(x: 0.2, y: 0.2),
            CGPoint(x: 0.8, y: 0.2),
            CGPoint(x: 0.8, y: 0.8),
            CGPoint(x: 0.2, y: 0.8),
            CGPoint(x: 0.5, y: 0.5)
        ]
        
        func moveToNextPoint() {
            currentStep = (currentStep + 1) % points.count
            withAnimation(.easeInOut(duration: 1)) {
                position = points[currentStep]
                scale = currentStep == 4 ? 1.5 : 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                moveToNextPoint()
            }
        }
        
        moveToNextPoint()
    }
    
    private func updateCircularMovement() {
        if exercise.category == .focus {
            let center = CGPoint(x: 0.5, y: 0.5)
            let radius: CGFloat = 0.3
            
            angle += 0.05
            position = CGPoint(
                x: center.x + radius * CGFloat(cos(angle)),
                y: center.y + radius * CGFloat(sin(angle))
            )
        }
    }
} 