//
//  CryptoDetails.Store.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Combine

import Foundation

class CryptoDetailsDataStore: ObservableObject {
    public init(cryptos: [CryptoDetails], currentCrypto: CryptoDetails) {
        self.cryptos = cryptos
        self.currentCrypto = currentCrypto
    }
    
    @Published var cryptos: [CryptoDetails]
    @Published var currentCrypto: CryptoDetails
    @Published var viewModel: CryptoDetailsModel.LoadCryptoList.ViewModel = .init(state: .loading)
    
}

#if DEBUG
extension CryptoDetailsDataStore {
  static var sample: CryptoDetailsDataStore {
      let model = CryptoDetailsDataStore(cryptos: [.sample, .sample], currentCrypto: .sample)
    return model
  }
}
#endif

//MARK: - Test preview with content
//@Published var viewModel: CryptoDetailsModel.LoadCryptoList.ViewModel = .init(state: .content([.init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43"), .init(price: 12, time: "2002 23 43")]))
