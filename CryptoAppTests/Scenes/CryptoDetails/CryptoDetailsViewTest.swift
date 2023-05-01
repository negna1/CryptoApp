//
//  CryptoDetailsViewTest.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import XCTest
@testable import CryptoApp

class CryptoDetailsViewTest: XCTestCase {
    var sut: CryptoDetailsView!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoDetailsView()
    }
    
    // MARK: - Tests (test that same crypto appear in view class as we pass
    func testCryptosPassing() {
        let cryptos: [CryptoDetails] =  [.sample, .sample]
        sut.configureView(cryptos: cryptos,
                          currentCrypto: .sample)
        XCTAssertEqual(
            sut.store.cryptos,
            cryptos,
            "Compare configuring"
        )
    }
    
    func testCurrentCrypto() {
        let currentCrypto: CryptoDetails = .sample
        sut.configureView(cryptos: [.sample, .sample],
                          currentCrypto: currentCrypto)
        XCTAssertEqual(
            sut.store.currentCrypto,
            currentCrypto,
            "Compare configuring"
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
