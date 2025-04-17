//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private  var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }.environmentObject(vm)
        }
    }
}
