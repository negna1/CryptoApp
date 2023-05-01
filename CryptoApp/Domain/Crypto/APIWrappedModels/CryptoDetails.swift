//
//  Crypto.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation
import NetworkLayer


struct CryptoDetails: Identifiable, Hashable, Equatable {
    init(id: String = UUID().uuidString,
          symbol: String,
          priceChange: Double? = nil,
          lastPrice: Double? = nil) {
        self.id = id
        self.symbol = symbol
        self.priceChange = priceChange
        self.lastPrice = lastPrice
    }
    
    static var sample = CryptoDetails(symbol: "ETH", priceChange: nil, lastPrice: nil)
    static var sample2 = CryptoDetails(symbol: "", priceChange: 12, lastPrice: nil)
    static var sample3 = CryptoDetails(symbol: "symbol3", priceChange: 12, lastPrice: 23)
    var id: String = UUID().uuidString
    let symbol: String
    let priceChange: Double?
    var lastPrice: Double?
    var icon: String {
        let str = String(symbol.lowercased().components(separatedBy: "/").first ?? "")
        let url = "https://fcsapi.com//assets//images//coin//\(str).png"
        let secondUrl = "https://coinicons-api.vercel.app/api/icon/\(str)"
        guard  URL(string: url) != nil else { return secondUrl }
        return url
    }
    
    var cryptoName: String {
        String(symbol.uppercased().components(separatedBy: "/").first ?? "")
    }
    
    var currencyName: String {
        String(symbol.uppercased().components(separatedBy: "/").last ?? "")
    }
}



