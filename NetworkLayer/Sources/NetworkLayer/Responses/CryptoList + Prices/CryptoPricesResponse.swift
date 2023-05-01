//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 29.04.23.
//

import Foundation

// MARK: - Welcome
public struct CryptoPricesResponse: Codable, Equatable {
    let status: Bool?
    let code: Int?
    let msg: String?
    public let response: [CryptoPriceResponse]?
    let info: CryptoProfilesInfo?
    
    public static var sample = CryptoPricesResponse(status: nil,
                                                    code: nil,
                                                    msg: nil,
                                                    response: [.sample],
                                                    info: nil)
}

// MARK: - Response
public struct CryptoPriceResponse: Codable, Equatable {
    public  let id, o, h, l: String?
    public  let c, ch, cp, t: String?
    //public  let s, tm: String?
    
    public static var sample = CryptoPriceResponse(id: "id",
                                                   o: "id",
                                                   h: "id",
                                                   l: nil,
                                                   c: "12",
                                                   ch: nil,
                                                   cp: nil,
                                                   t: nil)
}
