//
//  Crypto.ListView.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var cryptoStore: CryptoDataStore
    var details: [CryptoDetails]
    var body: some View {
        List {
            ForEach(details) {crypto in
                NavigationLink(value: crypto) {
                    HStack {
                        AsyncImageView(urlString: crypto.icon)
                        Text("\(crypto.cryptoName)  - ")
                            .font(.title2)
                        Text(crypto.lastPrice?.description ?? "Loading")
                            .font(.title3)
                        Text("\(crypto.currencyName)")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.leading)
                }
            }
            if details.count > CryptoDataStore.loadItemCount {
                ProgressView()
                    .onAppear {
                        cryptoStore.increaseItems()
                    }
            }
        }
        .navigationDestination(for: CryptoDetails.self) { crypto in
            CryptoDetailsView()
                .configureView(
                    cryptos: Array(cryptoStore.viewModel.cryptoList.values),
                    currentCrypto: crypto)
        }
    }
}
