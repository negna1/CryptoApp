//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 29.04.23.
//

import Foundation

// MARK: - Welcome
public struct CryptoProfilesResponse: Codable, Equatable {
    let status: Bool?
    let code: Int?
    let msg: String?
    public let response: [CryptoProfileResponse]?
    let info: CryptoProfilesInfo?
}

// MARK: - Info
public struct CryptoProfilesInfo: Codable, Equatable {
    let serverTime: String?
    let creditCount: Int?

    enum CodingKeys: String, CodingKey {
        case serverTime = "server_time"
        case creditCount = "credit_count"
    }
}

// MARK: - Response
public struct CryptoProfileResponse: Codable, Equatable {
    public let shortName, name: String?
    let country, codeN, subunit: String?
    let website: String?
    public let symbol: String?
    let bank, banknotes, coins: String?
    public let icon: String?
    let type: String?
    let symbol2, banknotes2, coins2, slug: String?
    let category: String?
    let icon1: String?
    let urls: CryptoProfileUrls?

    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case name, country
        case codeN = "code_n"
        case subunit, website, symbol, bank, banknotes, coins, icon, type
        case symbol2 = "symbol_2"
        case banknotes2 = "banknotes_2"
        case coins2 = "coins_2"
        case slug, category, icon1, urls
    }
}

// MARK: - Urls
public struct CryptoProfileUrls: Codable, Equatable {
    let technicalDoc: String?
    let twitter: String?
    let reddit: String
    let announcement: String?
    let sourceCode: String?

    enum CodingKeys: String, CodingKey {
        case technicalDoc = "technical_doc"
        case twitter, reddit, announcement
        case sourceCode = "source_code"
    }
}
