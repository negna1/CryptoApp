//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation

public struct CryptoDailyPricesResponse: Codable, Equatable {
    let status: Bool?
    let code: Int?
    let msg: String?
    public let response: [String: CryptoDailyPriceResponse]
    let info: CryptoDailyPricesResponseInfo?
    
    public static var sample = CryptoDailyPricesResponse.init(status: nil, code: nil, msg: nil, response: ["2023-05-01":.sample], info: nil)
}

// MARK: - Info
public struct CryptoDailyPricesResponseInfo: Codable, Equatable {
    let id, decimal, symbol, period: String?
    let serverTime: String?
    let creditCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, decimal, symbol, period
        case serverTime = "server_time"
        case creditCount = "credit_count"
    }
}

// MARK: - Response
public struct CryptoDailyPriceResponse: Codable, Equatable {
    public let o, h, l, c: String?
    let v: String?
    let t: Int?
    public let tm: String?
    
    public static var sample = CryptoDailyPriceResponse(o: nil,
                                                        h: nil,
                                                        l: nil,
                                                        c: "12",
                                                        v: nil,
                                                        t: nil,
                                                        tm: "2023-05-01")
}
