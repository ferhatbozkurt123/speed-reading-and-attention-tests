//
//  quickreadApp.swift
//  quickread
//
//  Created by Ferhat Bozkurt on 25.01.2025.
//

import SwiftUI
import Foundation // Question için

@main
struct quickreadApp: App {
    init() {
        NotificationManager.shared.requestPermission { granted in
            print("Bildirim izni: \(granted)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
