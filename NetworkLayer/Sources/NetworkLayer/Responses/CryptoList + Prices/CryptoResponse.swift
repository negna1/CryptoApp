//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 29.04.23.
//

import Foundation

// MARK: - CryptoResponse
public struct CryptoResponseData: Codable, Equatable {
    let status: Bool?
    let code: Int?
    let msg: String?
    public let response: [CryptoResponse]?
    let info: CryptoInfo?
    
    public static var sample = CryptoResponseData(status: nil,
                                                  code: 200,
                                                  msg: "success",
                                                  response: [.sample],
                                                  info: nil)
}

// MARK: - Info
public struct CryptoInfo: Codable, Equatable {
    let serverTime: String?
    let creditCount: Int?

    enum CodingKeys: String, CodingKey {
        case serverTime = "server_time"
        case creditCount = "credit_count"
    }
}

// MARK: - Response
public struct CryptoResponse: Codable, Equatable {
    public let id, name, decimal, symbol: String?
    
    public static var sample = CryptoResponse(id: nil,
                                              name: "ETH",
                                              decimal: "12",
                                              symbol: "ETH")
}

