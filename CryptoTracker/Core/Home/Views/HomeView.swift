//
//  HomeView.swift
//  CryptoTracker
//
//  Created by FerVP on 16/04/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    
    
    @State private var showPortfolio: Bool = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                homeHeader
                HStack{
                    Text("Coin")
                    Spacer()
                    if(showPortfolio){
                        Text("Holdings")
                    }
                    Text("Price")
                        .frame(width : UIScreen.main.bounds.width/3.5,alignment: .trailing)
                }
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .padding(.horizontal)
                if !showPortfolio{
                    List{
                        
                        ForEach(vm.coins){ coin in
                            CoinRowView(coin: coin,showHoldings: false)
                                .listRowInsets(.init(top: 10, leading: 00, bottom: 10, trailing: 10))
                        }
                        
                    }.listStyle(.plain)
                        .transition(.move(edge: .leading))
                    
                }else{
                    List{
                        
                        ForEach(vm.portfolioCoins){ coin in
                            CoinRowView(coin: coin,showHoldings: true)
                                .listRowInsets(.init(top: 10, leading: 00, bottom: 10, trailing: 10))
                        }
                        
                    }.listStyle(.plain)
                        .transition(.move(edge: .trailing))
                    
                }
                
                Spacer ( minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        
        HomeView()
            .toolbar(.hidden)
    }.environmentObject(DeveloperPreview.instance.homeVM)
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
