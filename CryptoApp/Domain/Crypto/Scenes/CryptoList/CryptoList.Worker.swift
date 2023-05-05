//
//  CryptoList.Worker.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import NetworkLayer
import Foundation

protocol CryptoListDisplayWorker {
    func fetcCryptoList() async -> Result<CryptoResponseData, ErrorType>
    func fetcCryptoPrices() async -> Result<CryptoPricesResponse, ErrorType>
}

final class CryptoListDisplay: CryptoListDisplayWorker {
    public var networkLayer: NetworkLayerProtocol = NetworkLayer()
    func fetcCryptoList() async -> Result<CryptoResponseData, ErrorType> {
        let request = URLRequest.allCrypto()
        let response = await networkLayer.fetchAsync(for: request, with: CryptoResponseData.self)
        return response
    }
    
    func fetcCryptoPrices() async -> Result<CryptoPricesResponse, ErrorType> {
        let request = URLRequest.pricesCrypto()
        let response = await networkLayer.fetchAsync(for: request, with: CryptoPricesResponse.self)
        return response
    }
}
