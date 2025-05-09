//
//  ContentView.swift
//  quickread
//
//  Created by Ferhat Bozkurt on 25.01.2025.
//

import SwiftUI

struct ContentView: View {
    let primaryColor = Color.blue
    let secondaryColor = Color.purple
    
    var body: some View {
        NavigationView {
            List {
                Section(header: sectionHeader("Egzersizler")) {
                    navigationRow(icon: "eye.fill", title: "Göz Egzersizleri", destination: EyeExerciseView())
                    navigationRow(icon: "book.closed.fill", title: "Kelime Tanıma", destination: WordRecognitionView())
                    navigationRow(icon: "speedometer", title: "Hız Okuma", destination: SpeedReadingView())
                    navigationRow(icon: "brain.head.profile", title: "Anlama Testleri", destination: ComprehensionView())
                }
                
                Section(header: sectionHeader("Bilgiler")) {
                    navigationRow(icon: "chart.bar.fill", title: "İlerleme Durumu", destination: ProgressView())
                    navigationRow(icon: "gearshape.fill", title: "Ayarlar", destination: SettingsView())
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("QuickRead")
            .navigationBarTitleDisplayMode(.large)
            .accentColor(primaryColor)
            .tint(primaryColor)
        }
    }
    
    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.system(.subheadline, design: .rounded).bold())
            .textCase(.uppercase)
            .foregroundColor(secondaryColor)
            .padding(.vertical, 8)
    }
    
    private func navigationRow<Destination: View>(icon: String, title: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(LinearGradient(gradient: Gradient(colors: [primaryColor, secondaryColor]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color(.secondarySystemBackground))
        .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 12, trailing: 12))
    }
}
