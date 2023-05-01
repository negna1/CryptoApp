//
//  CryptoDailyPrice.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation
import NetworkLayer

struct CryptoDailyPrice: Identifiable, Hashable {
    init(id: String = UUID().uuidString,
          price: Double,
          time: String) {
        self.id = id
        self.price = price
        self.time = time
    }
    
    static var sample = CryptoDetails.sample
    var id: String = UUID().uuidString
    let price: Double
    var time: String
    
    init(with dailyPrice: CryptoDailyPriceResponse) {
        self.price = Double(dailyPrice.c ?? "0") ?? 0
        self.time = dailyPrice.tm ?? ""
    }
}
