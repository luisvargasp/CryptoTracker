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
    @State private var showPortfolioView = false
    @State private var showInfoView = false
    
    @State var stackPath : [CoinModel] = []

    var body: some View {
        ZStack{
            
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                    
                })
               
            
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
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
                .sheet(isPresented: $showInfoView, content: {
                    InfoView() 
                })
                if !showPortfolio{
                    List{
                        
                        ForEach(vm.coins){ coin in
                            
                            NavigationLink(value : coin, label: {
                                CoinRowView(coin: coin,showHoldings: false)
                                    .listRowInsets(.init(top: 10, leading: 00, bottom: 10, trailing: 10))
                            })
                            
            
                        
                            
                            //.listRowSeparator(.hidden)
                        }
                        
                        
                    }.listStyle(.plain)
                        .transition(.move(edge: .leading))
                        .refreshable {
                            vm.reloadData()
                        }
                      
                    
                    
                }else{
                    List{
                        
                        ForEach(vm.portfolioCoins){ coin in
                            NavigationLink(value : coin, label: {
                                CoinRowView(coin: coin,showHoldings: false)
                                    .listRowInsets(.init(top: 10, leading: 00, bottom: 10, trailing: 10))
                            })
                        }
                        
                    }.listStyle(.plain)
                        .transition(.move(edge: .trailing))
                    
                }
                   
                
                
                Spacer ( minLength: 0)
            }
            .navigationDestination(for: CoinModel.self , destination: {
                coin in DetailView(coin: coin)
            } )
        
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }else{
                        showInfoView.toggle()
                    }
                }
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
