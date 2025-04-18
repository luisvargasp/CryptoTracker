//
//  CoinimageView.swift
//  CryptoTracker
//
//  Created by FerVP on 17/04/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
      private let dataService: CoinImageService
      private var cancellables = Set<AnyCancellable>()
      
      init(coin: CoinModel) {
          self.coin = coin
          self.dataService = CoinImageService(coin: coin)
          self.addSubscribers()
          self.isLoading = true
      }
      
      private func addSubscribers() {
          dataService.$image
              .sink { [weak self] (_) in
                  self?.isLoading = false
              } receiveValue: { [weak self] (returnedImage) in
                  self?.image = returnedImage
              }
              .store(in: &cancellables)
          
      }
}

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
        
        init(coin: CoinModel) {
            _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
        }
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
                
            }else{
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
}
