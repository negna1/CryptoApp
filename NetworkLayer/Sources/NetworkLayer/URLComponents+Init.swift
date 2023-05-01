//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation


public extension URLComponents {
    
    init(scheme: String = "https",
                host: String = "myApp.com",
                path: String,
                queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        self = components
    }
    
    init(scheme: String = "https",
                host: HostType,
                path: PathType,
                queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host.rawValue
        components.path = path.rawValue
        components.queryItems = queryItems
        self = components
    }
}

public protocol Bodyable {
    var toBody: [String: Any] {get set}
}

public enum HostType: String {
    case binance = "data.binance.com"
    case fscapi = "fcsapi.com"
}

public enum PathType: String {
    case ticker = "/api/v3/ticker/24hr"
    case allCrypto = "/api-v3/crypto/list"
    case history = "/api-v3/crypto/history"
    case prices = "/api-v3/crypto/latest"
}

public var APIKEY = "sywA1f3UqERuqrBHmqIBN"
