//
//  CryptoDetails.View.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI
import NetworkLayer

protocol CryptoDetailsDisplayLogic {
    func displayCrypto(viewModel: CryptoDetailsModel.LoadCryptoList.ViewModel)
    func fetchPrice(with symbol: String) 
}

extension CryptoDetailsView: CryptoDetailsDisplayLogic {
    func fetchPrice(with symbol: String) {
        if lastcrypto == symbol { return }
        lastcrypto = symbol
        interactor?.loadCrypto(request: .history(symbol: symbol))
    }
    
    func displayCrypto(viewModel: CryptoDetailsModel.LoadCryptoList.ViewModel) {
        store.viewModel = viewModel
    }
}

struct CryptoDetailsView_Previews: PreviewProvider {
    static var previews: some View {

        CryptoDetailsView(store: .init(cryptos: [.sample, .sample2, .sample3, .sample, .sample3], currentCrypto: .sample))
    }
}

struct CryptoDetailsView: View {
    @ObservedObject var store: CryptoDetailsDataStore = .sample
    @State private var currentIndex = 0
    @State var isPresented: Bool = false
    @State var lastcrypto: String = ""
    var interactor: CryptoDetailsInteractor?
    var body: some View {
        VStack {
            ScrollView {
                LazyHStack {
                    TabView(selection: $store.currentCrypto) {
                        ForEach(store.cryptos, id: \.id) { item in
                            ItemView(store: store, item: item)
                                .onChange(of: store.currentCrypto) { newValue in
                                    Task {
                                        await fetchPrice(with: (newValue.symbol))
                                    }
                                }
                                .tag(item)
                        }
                        .padding(.all, Constant.padding)
                    }
                    .tabViewModifier()
                }}
        }
    }
}
