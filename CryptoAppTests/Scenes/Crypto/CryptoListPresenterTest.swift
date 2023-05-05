//
//  CryptoListPresenterTest.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import XCTest
@testable import CryptoApp

class CryptoListPresenterTests: XCTestCase {
    var sut: CryptoListPresenter!
    var viewSpy: CryptoListViewSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoListPresenter()
        viewSpy = CryptoListViewSpy()
    }
    
    // MARK: - Test doubles
    class CryptoListViewSpy: CryptoListDisplayLogic {
        func updatePrices(prices: [(id: String, price: Double)]) {
            updatePricesCall = true
        }
        
        func fetchPrices() {
            fetchPriceCall = true
        }
        
        func viewAppear() {
            viewAppearCall = true
        }
        
        func displayCrypto(viewModel: CryptoList.LoadCryptoList.ViewModel) {
            self.state = viewModel.state
        }
        var viewAppearCall: Bool = false
        var fetchPriceCall: Bool = false
        var updatePricesCall: Bool = false
        var state: CryptoList.LoadCryptoList.ViewModel.State = .loading
    }
    
    // MARK: - Tests
    func testLoadCryptoListLoading() {
        // Given
        sut.view = viewSpy
        XCTAssertEqual(
            self.viewSpy.state,
            CryptoList.LoadCryptoList.ViewModel.State.loading,
            "Load crypto response in view"
        )
    }
    
    // MARK: - Tests
    func testLoadCryptoListByPresenter() async {
        // Given
        sut.view = viewSpy
        sut.presentCryptoList(response: .cryptoResponse(.success(.sample)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(
                self.viewSpy.state,
                CryptoList.LoadCryptoList.ViewModel.State.content([.sample]),
                "Load crypto response in view"
            )
        }
    }
    
    func testLoadCryptoPricesByPresenter() async {
        sut.view = viewSpy
        sut.presentCryptoList(response: .cryptoPrices(.success(.sample)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(
                self.viewSpy.state,
                CryptoList.LoadCryptoList.ViewModel.State.content([.sample]),
                "Load crypto response in view"
            )
        }
    }
    
    func testLoadCryptoListViewAppear() async {
        viewSpy.viewAppear()
        sut.view = viewSpy
        XCTAssertEqual(
            self.viewSpy.viewAppearCall,
            true,
            "View didnt appear"
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }
}
