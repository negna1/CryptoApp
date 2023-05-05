//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 05.05.23.
//

import Foundation

public enum HostType: String {
    case binance = "data.binance.com"
    case fscapi = "fcsapi.com"
    case example = "api.github.com"
}

public enum PathType: String {
    case ticker = "/api/v3/ticker/24hr"
    case allCrypto = "/api-v3/crypto/list"
    case history = "/api-v3/crypto/history"
    case prices = "/api-v3/crypto/latest"
    case example = "/users/hadley/orgs"
}

public var APIKEY = "sywA1f3UqERuqrBHmqIBN"

extension HostType: HostTypable {
    public var host: String {
        self.rawValue
    }
}

extension PathType: PathTypable {
    public var path: String {
        self.rawValue
    }
}
