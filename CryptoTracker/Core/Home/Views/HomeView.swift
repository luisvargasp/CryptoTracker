//
//  HomeView.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                homeHeader
                Spacer ( minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        
        HomeView()
            .toolbar(.hidden)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" :"info")
                .animation(.none,value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none,value: showPortfolio)

            Spacer()

            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        self.showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
}
