//
//  CryptoDetails.Interactor.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation

protocol CryptoDetailsBusinessLogic {
    func loadCrypto(request: CryptoDetailsModel.LoadCryptoList.Request) async
}

final class CryptoDetailsInteractor {
    var presenter: CryptoDetailsPresentationLogic?
    var worker: CryptoDetailsDisplayWorker?
}

extension CryptoDetailsInteractor: CryptoDetailsBusinessLogic {
    func loadCrypto(request: CryptoDetailsModel.LoadCryptoList.Request) async {
        switch request {
        case .history(let symbol):
            guard let result = await worker?.fetchCrypotDailyPrices(symbol: symbol) else { return }
            await presenter?.presentCryptoDailyPrices(response: CryptoDetailsModel.LoadCryptoList.Response.cryptoPrices(result))
        }
    }
}


