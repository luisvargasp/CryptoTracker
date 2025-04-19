//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by FerVP on 17/04/25.
//

import Foundation
import Combine
class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    private var apiKey   = "CG-1FyrBDH34BXJ3zJYmaXsoWps"
    
    var coinsSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    func getCoins() {
        guard let url = URL(string:  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h")
        else {
            print("Invalid URL")
            return }
        coinsSubscription = NetworkingManager.download(url: url)
                    .decode(type: [CoinModel].self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                        self?.allCoins = returnedCoins
                        self?.coinsSubscription?.cancel()
                    })
        
        
        
    }
}
