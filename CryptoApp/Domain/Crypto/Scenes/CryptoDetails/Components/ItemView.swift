//
//  ItemView.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import SwiftUI

extension CryptoDetailsView {
    struct ItemView: View {
        @ObservedObject var store: CryptoDetailsDataStore
        var item: CryptoDetails
        var body: some View {
            VStack {
                Text(item.symbol)
                    .font(.title)
                AsyncImageView(urlString: item.icon, size: Constant.imageSize )
                switch store.viewModel.state {
                case .loading:
                    ProgressView()
                case .content(let prices):
                    DailyListView(details: prices)
                case .error(let error):
                    Text(error.localizedDescription)
                }
            }
        }
    }
}


