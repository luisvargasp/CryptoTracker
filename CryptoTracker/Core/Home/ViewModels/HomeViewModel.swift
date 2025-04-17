//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by FerVP on 17/04/25.
//

import Foundation
class HomeViewModel : ObservableObject {
    
    @Published var coins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
        
    }
}
