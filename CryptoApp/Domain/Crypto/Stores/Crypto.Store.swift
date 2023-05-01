//
//  Crypto.DataStore.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Combine

import Foundation

class CryptoDataStore: ObservableObject {
    private var cancelables = Set<AnyCancellable>()
    private var bindFlag: Bool = false
    
    @Published var searchText: String = ""
    @Published var viewModel: CryptoList.LoadCryptoList.ViewModel = .init(state: .loading)
    static var loadItemCount = 20
    var initialItems = CryptoDataStore.loadItemCount
    lazy var contentCount = viewModel.cryptoList.count
    
    init() {
        bindSearch()
        bindFlag = true
    }
    
    func updateViewModelWithPrices(prices: [(id: String, price: Double)]) {
        prices.forEach { res in
            viewModel.cryptoList[res.id]?.lastPrice = res.price
        }
        guard viewModel.cryptoList.count > initialItems else { return }
        let values = Array(viewModel.cryptoList.values)
        viewModel.currentCryptos = Array(values[0...initialItems])
        self.viewModel.state = .content(viewModel.currentCryptos)
    }
    
    func increaseItems()  {
        if initialItems + CryptoDataStore.loadItemCount < contentCount {
            initialItems += CryptoDataStore.loadItemCount
            let values = Array(viewModel.cryptoList.values)
            viewModel.currentCryptos = Array(values[0...initialItems])
            self.viewModel.state = .content(viewModel.currentCryptos)
        }
    }
    
    private var needToUpdateContent: Bool {
        guard self.bindFlag else { return false}
        switch self.viewModel.state {
        case .loading, .error(_):
            return false
        case .content(_):
            return true
        }
    }
    
    func bindSearch() {
        $searchText.sink { search in
            guard self.needToUpdateContent else { return }
            self.initialItems = CryptoDataStore.loadItemCount
            guard !search.isEmpty else {
                self.contentCount = self.contentCount
                self.increaseItems()
                return
            }
            let result = Array(self.viewModel.cryptoList.values).filter({$0.symbol.lowercased().contains(search.lowercased())})
            self.contentCount = result.count
            self.viewModel.state = .content(result)
        }.store(in: &cancelables)
    }
}

#if DEBUG
extension CryptoDataStore {
  static var sample: CryptoDataStore {
    let model = CryptoDataStore()
      model.viewModel = .init(state: .content([.init(symbol: "ETH/USD", lastPrice: 1345)]))
    return model
  }
}
#endif

 
