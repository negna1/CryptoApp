//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation

extension URLComponents {
    public static func history(queries: [URLQueryItem])-> Self {
        URLComponents(host: HostType.fscapi,
                             path: PathType.history,
                             queryItems: queries)
    }
    
    public static func allCrypto(queries: [URLQueryItem]) -> Self {
        URLComponents(host: HostType.fscapi,
                             path: PathType.allCrypto,
                      queryItems: queries)
    }
    
    public static func pricesCrypto(queries: [URLQueryItem]) -> Self {
        URLComponents(host: HostType.fscapi,
                             path: PathType.prices,
                      queryItems: queries)
    }
}

extension URLRequest {
    public static func history(queries: [URLQueryItem])-> Self {
        URLRequest(components: .history(queries: queries))
    }
    
    public static func allCrypto(queries: [URLQueryItem] = [.accessKey, .typecrypto]) -> Self {
        URLRequest(components: .allCrypto(queries: queries))
    }
    
    public static func pricesCrypto(queries: [URLQueryItem] = [.accessKey, .symbolcrypto]) -> Self {
        URLRequest(components: .pricesCrypto(queries: queries))
    }
}

extension URLQueryItem {
    public static var accessKey: Self {
        URLQueryItem(name: "access_key", value: APIKEY)
    }
    
    public static var typecrypto: Self {
        URLQueryItem(name: "type", value: "crypto")
    }
    
    public static var symbolcrypto: Self {
        URLQueryItem(name: "symbol", value: "all_crypto")
    }
}
