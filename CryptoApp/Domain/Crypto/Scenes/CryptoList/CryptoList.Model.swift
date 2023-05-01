//
//  CryptoList.Model.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation
import NetworkLayer

enum CryptoList {
    enum LoadCryptoList {
        enum Request {
            case prices
            case cryptoList
        }
        
        enum Response {
            case cryptoResponse(Result<CryptoResponseData, ErrorType>)
            case cryptoPrices( Result<CryptoPricesResponse, ErrorType>)
        }
        
        struct ViewModel {
            var cryptoList = [String : CryptoDetails]()
            var currentCryptos = [CryptoDetails]()
            var state: State
            enum State: Equatable {
                case loading
                case content([CryptoDetails])
                case error(ErrorType)
            }
        }
    }
}
