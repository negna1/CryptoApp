//
//  CryptoDetails.Worker.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import NetworkLayer
import Foundation

protocol CryptoDetailsDisplayWorker {
    func fetchCrypotDailyPrices(symbol: String) async -> Result<CryptoDailyPricesResponse, ErrorType> 
}

final class CryptoDetailsDisplay: CryptoDetailsDisplayWorker {
    public init() {}
    func fetchCrypotDailyPrices(symbol: String) async -> Result<CryptoDailyPricesResponse, ErrorType> {
        let request = URLRequest.history(queries: [.init(name: "symbol", value: symbol),
                                                   .accessKey])
        let response = await fetchAsync(for: request, with: CryptoDailyPricesResponse.self)
        return response
    }
}

