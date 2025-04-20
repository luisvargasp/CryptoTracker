//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @State private var showLaunchView: Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        
        
        
    }
    
    @StateObject private  var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden)
                }.environmentObject(vm)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            
        }
    }
}
