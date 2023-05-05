//
//  CryptoList.Interactor.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation

protocol CryptoListBusinessLogic {
    func loadCrypto(request: CryptoList.LoadCryptoList.Request)
}

final class CryptoListInteractor {
    var presenter: CryptoListPresentationLogic?
    var worker: CryptoListDisplayWorker?
}

extension CryptoListInteractor: CryptoListBusinessLogic {
    func loadCrypto(request: CryptoList.LoadCryptoList.Request) {
        switch request {
        case .cryptoList:
            loadCrypto()
        case .prices:
            loadCryptoPrices()
        }
    }
    
    func loadCrypto() {
        Task {
            guard let response = await worker?.fetcCryptoList() else { return }
            let wrappedResponse =  CryptoList.LoadCryptoList.Response.cryptoResponse(response)
            await presenter?.presentCryptoList(response: wrappedResponse)
        }
    }
    
    func loadCryptoPrices()  {
        Task {
            guard let response = await worker?.fetcCryptoPrices() else { return }
            let wrappedResponse =  CryptoList.LoadCryptoList.Response.cryptoPrices(response)
            await presenter?.presentCryptoList(response: wrappedResponse)
        }
    }
}

