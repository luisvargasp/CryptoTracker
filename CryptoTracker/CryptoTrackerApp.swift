//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
