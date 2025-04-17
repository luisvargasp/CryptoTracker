//
//  ContentView.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                
                Text("Secondary Color")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundStyle(Color.theme.red)
                
                Text("Green Color")
                    .foregroundStyle(Color.theme.green)
            }.font(.headline)
        }
    
    }
}

#Preview {
    ContentView()
}
