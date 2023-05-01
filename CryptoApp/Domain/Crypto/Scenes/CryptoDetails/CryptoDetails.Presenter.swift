//
//  CryptoDetails.Presenter.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation
import NetworkLayer

protocol CryptoDetailsPresentationLogic {
    func presentCryptoDailyPrices(response: CryptoDetailsModel.LoadCryptoList.Response) async
}

final class CryptoDetailsPresenter {
    var view: CryptoDetailsDisplayLogic?
}

extension CryptoDetailsPresenter: CryptoDetailsPresentationLogic {
    func presentCryptoDailyPrices(response: CryptoDetailsModel.LoadCryptoList.Response) async {
        switch response {
        case .cryptoPrices(let response):
            switch response {
            case .success(let success):
                await self.successCryptoDailyPrice(success)
            case .failure(let failure):
                self.failCryptoDailyPrice(failure)
            }
        }
    }
}

//MARK: - Success and Fail -
extension CryptoDetailsPresenter {
    private func getTodayPricesFiltered(_ prices: CryptoDailyPricesResponse) ->  [String : CryptoDailyPriceResponse] {
        prices.response.filter({(Double($0.key) ?? 0) >= Date.today})
    }
    
    private func successCryptoDailyPrice(_ prices: CryptoDailyPricesResponse) async {
        
        let priceFilteredToday = getTodayPricesFiltered(prices)
        let wrappedPrices = Array(priceFilteredToday.values).map({CryptoDailyPrice(with: $0)})
        let viewModel = CryptoDetailsModel.LoadCryptoList.ViewModel(cryptoPrices: wrappedPrices,
                                                                    state: .content(wrappedPrices))
        DispatchQueue.main.async {
            self.view?.displayCrypto(viewModel: viewModel)
        }
    }
    
    private func failCryptoDailyPrice(_ error: ErrorType) {
        let viewModel = CryptoDetailsModel.LoadCryptoList.ViewModel.init(state: .error(error))
        DispatchQueue.main.async {
            self.view?.displayCrypto(viewModel: viewModel)
        }
    }
}
