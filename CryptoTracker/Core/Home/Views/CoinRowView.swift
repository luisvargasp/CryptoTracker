//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by FerVP on 17/04/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    let showHoldings : Bool
    var body: some View {
        HStack(spacing : 0)
        {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            if(showHoldings){
                VStack(alignment: .trailing){
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals() )
                        .bold(true)
                    
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }.foregroundStyle(Color.theme.accent)
            }
            VStack(alignment : .trailing){
                Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                    .foregroundStyle(Color.theme.accent)
                Text("\((coin.priceChangePercentage24H ?? 0).asPercentString())")
                    .foregroundStyle((coin.priceChange24H ?? 0 )>=0 ? Color.theme.green : Color.theme.red)
            }.frame(width : UIScreen.main.bounds.width/3.5,alignment: .trailing)
           
        }.font(.subheadline)
       
    }
}

#Preview {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldings: true)
}
