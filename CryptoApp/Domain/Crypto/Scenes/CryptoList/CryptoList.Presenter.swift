//
//  CryptoList.Presenter.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation
import NetworkLayer

protocol CryptoListPresentationLogic {
    func presentCryptoList(response: CryptoList.LoadCryptoList.Response)
}

final class CryptoListPresenter {
    var view: CryptoListDisplayLogic?
}

extension CryptoListPresenter: CryptoListPresentationLogic {
    func presentCryptoList(response: CryptoList.LoadCryptoList.Response) {
        switch response {
        case .cryptoResponse(let result):
            self.cryptoListResponse(response: result)
        case .cryptoPrices(let result):
            self.cryptoPriceResponse(response: result)
        }
    }
    
    func cryptoListResponse(response: Result<CryptoResponseData, ErrorType>) {
        switch response {
        case .success(let cryptos):
            self.successCryptoList(cryptos)
        case .failure(let error):
            self.failCryptoList(error)
        }
    }
    
    func cryptoPriceResponse(response: Result<CryptoPricesResponse, ErrorType>) {
        switch response {
        case .success(let cryptos):
            DispatchQueue.main.async {
                let prices = cryptos.response?.map({($0.id ?? "", Double($0.c ?? "") ?? 0)}) ?? []
                self.view?.updatePrices(prices: prices)
            }
        case .failure(let error):
            self.failCryptoList(error)
        }
    }
}

//MARK: - Success and Fail -
extension CryptoListPresenter {
    
    private func successCryptoList(_ cryptos: CryptoResponseData)  {
        let viewModel = getViewModel(cryptos)
        DispatchQueue.main.async {
            self.view?.displayCrypto(viewModel: viewModel)
        }
        self.view?.fetchPrices()
    }
    
    private func failCryptoList(_ error: ErrorType) {
        let viewModel = CryptoList.LoadCryptoList.ViewModel.init(state: .error(error))
        DispatchQueue.main.async {
            self.view?.displayCrypto(viewModel: viewModel)
        }
    }
    
    private func getViewModel(_ cryptos: CryptoResponseData) -> CryptoList.LoadCryptoList.ViewModel{
        var dict = [String: CryptoDetails]()
        cryptos.response?.forEach({ resp in
            guard let id = resp.id,
                  let symbol = resp.symbol else { return }
            dict[id] = CryptoDetails.init(id: id, symbol: symbol)
        })
        let neetToCutDown = dict.count > CryptoDataStore.loadItemCount
        let values = Array(dict.values)
        let shownvalues = neetToCutDown ? Array(values[0...CryptoDataStore.loadItemCount]) : values
        return CryptoList.LoadCryptoList.ViewModel(cryptoList: dict,
                                                   currentCryptos: shownvalues,
                                                   state: .content(shownvalues))
    }
}
