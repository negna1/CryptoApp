//
//  CryptoDetailsPresenterTests.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import XCTest
@testable import CryptoApp

class CryptoDetailsPresenterTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    var sut: CryptoDetailsPresenter!
    var viewSpy: CryptoDetailsViewSpy!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoDetailsPresenter()
        viewSpy = CryptoDetailsViewSpy()
    }
    
    // MARK: - Test doubles
    class CryptoDetailsViewSpy: CryptoDetailsDisplayLogic {
        func displayCrypto(viewModel: CryptoApp.CryptoDetailsModel.LoadCryptoList.ViewModel) {
            self.state = viewModel.state
        }
        
        func fetchPrice(with symbol: String) async {
            fetchPriceCall = true
        }
        
        var fetchPriceCall: Bool = false
        var updatePricesCall: Bool = false
        var state: CryptoDetailsModel.LoadCryptoList.ViewModel.State = .loading
    }
    
    // MARK: - Tests
    func testLoadCryptoListLoading() {
        // Given
        sut.view = viewSpy
        XCTAssertEqual(
            self.viewSpy.state,
            CryptoDetailsModel.LoadCryptoList.ViewModel.State.loading,
            "Load crypto response in view"
        )
    }
    
    // MARK: - Tests
    func testLoadCryptoListByPresenter() async {
        // Given
        sut.view = viewSpy
        await sut.presentCryptoDailyPrices(response: .cryptoPrices(.success(.sample)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(
                self.viewSpy.state,
                CryptoDetailsModel.LoadCryptoList.ViewModel.State.content([CryptoDailyPrice.init(with: .sample)]),
                "Load crypto response in view"
            )
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }
}
