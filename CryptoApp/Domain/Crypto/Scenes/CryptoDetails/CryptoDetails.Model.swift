//
//  CryptoDetails.Model.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation
import NetworkLayer

enum CryptoDetailsModel {
    enum LoadCryptoList {
        enum Request {
            case history(symbol: String)
        }
        
        enum Response {
            case cryptoPrices(Result<CryptoDailyPricesResponse, ErrorType>)
        }
        
        struct ViewModel {
            var cryptoPrices = [CryptoDailyPrice]()
            var state: State
            enum State: Equatable {
                case loading
                case content([CryptoDailyPrice])
                case error(ErrorType)
            }
        }
    }
}
