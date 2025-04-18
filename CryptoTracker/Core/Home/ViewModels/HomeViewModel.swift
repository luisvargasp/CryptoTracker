//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by FerVP on 17/04/25.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    
    @Published var statistics: [StatisticModel] = [StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34),StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34),StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)]
    
    @Published var coins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
  

    
    @Published var searchText : String = ""
    
    var cancellables =  Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init() {
      
        addSubscribers()
        
        
    }
    func addSubscribers(){
        dataService.$allCoins.sink { [weak self] coins in
            self?.coins = coins
        }.store(in: &cancellables)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)

            .map { (searchText, coins ) -> [CoinModel] in
                guard !searchText.isEmpty else {
                    return coins
                }
                
                let lowercasedSearchText = searchText.lowercased()
                return coins.filter { coin in
                    coin.name.lowercased().contains(lowercasedSearchText) ||
                    coin.symbol.lowercased().contains(lowercasedSearchText) ||
                    coin.id.lowercased( ).contains(lowercasedSearchText)
                }
            }.sink { [weak self] filteredCoins in
                self?.coins = filteredCoins
            }.store(in: &cancellables)
           
        
   
        
    }
    
  
}
