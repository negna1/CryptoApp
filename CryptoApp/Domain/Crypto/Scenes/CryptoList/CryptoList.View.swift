//
//  CryptoList.View.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI

protocol CryptoListDisplayLogic {
    func displayCrypto(viewModel: CryptoList.LoadCryptoList.ViewModel)
    func updatePrices(prices: [(id: String, price: Double)])
    func viewAppear()
    func fetchPrices()
}

extension CryptoListView: CryptoListDisplayLogic {
    private func fetchCryptos() {
        interactor?.loadCrypto(request: .cryptoList)
    }
    
    func fetchPrices() {
        interactor?.loadCrypto(request: .prices)
    }
    
    func updatePrices(prices: [(id: String, price: Double)]) {
        cryptoStore.updateViewModelWithPrices(prices: prices)
    }
    
    func displayCrypto(viewModel: CryptoList.LoadCryptoList.ViewModel) {
        cryptoStore.viewModel = viewModel
    }
    
    func viewAppear()  {
        guard !isPresented else { return }
        cryptoStore.viewModel.state = .loading
        self.isPresented = true
        fetchCryptos()
    }
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {

        CryptoListView(cryptoStore: .sample)
    }
}

struct CryptoListView: View {
    var interactor: CryptoListBusinessLogic?
    @State var isPresented: Bool = false
    @ObservedObject var cryptoStore = CryptoDataStore()
    var body: some View {
        NavigationStack {
            VStack {
                switch cryptoStore.viewModel.state {
                case .content(let details):
                    ListView(cryptoStore: cryptoStore,
                             details: details)
                case .loading:
                    ActivityIndicator()
                        .frame(width: 50, height: 50)
                case .error(let error):
                    VStack {
                        Text(error.localizedDescription)
                            .foregroundColor(Color(Constant.Color.error))
                        Button(Constant.reload){
                            viewAppear()
                        }.primaryButton(backgroundColor: Color(Constant.Color.error))
                    }
                }
            }
            .navigationTitle(Constant.navigationTitle)
            .onAppear {
                viewAppear()
            }
        }
        .searchable(text: $cryptoStore.searchText, prompt: Constant.search)
        .navigationViewStyle(.stack)
    }
}
