//
//  CryptoDetailsInteractorTests.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation

import XCTest
import NetworkLayer
@testable import CryptoApp

class CryptoDetailsInteractorTests: XCTestCase {
    var sut: CryptoDetailsInteractor!
    var presenterSpy: CryptoDetailsPresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoDetailsInteractor()
        sut.worker = workerSpy()
        presenterSpy = CryptoDetailsPresenterSpy()
    }
    
    // MARK: - Tests
    func testSuccessCall() async {
        // Given
        sut.presenter = presenterSpy
        let cryptoList: CryptoDailyPricesResponse = .sample
        let expectation = self.expectation(description: "Waiting for the retrieveAlumni call to complete.")
        sut.loadCrypto(request: .history(symbol: "ETH"))
        expectation.fulfill()
        
        await waitForExpectations(timeout: 4) { error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.presenterSpy.cryptoResponse,
                cryptoList.response,
                "Success error"
            )
        }
    }
    
    func testErrorCall() async {
        // Given
        sut.worker = ErrorWorkerSpy()
        sut.presenter = presenterSpy
        // When
        let request = CryptoList.LoadCryptoList.Request.cryptoList
        let expectation = self.expectation(description: "Waiting for the get crypto  call to complete.")
        Task {
            await sut.loadCrypto(request: .history(symbol: "ETH"))
            expectation.fulfill()
        }
        
        await waitForExpectations(timeout: 4) { error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.presenterSpy.err,
                .urlError,
                "Error case error"
            )
        }
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        try super.tearDownWithError()
    }
}

//MARK: - Worker spys -
extension CryptoDetailsInteractorTests {
    class workerSpy: CryptoDetailsDisplayWorker {
        func fetchCrypotDailyPrices(symbol: String) async -> Result<CryptoDailyPricesResponse, ErrorType> {
            return .success(.sample)
        }
    }
    
    class ErrorWorkerSpy: CryptoDetailsDisplayWorker {
        func fetchCrypotDailyPrices(symbol: String) async -> Result<CryptoDailyPricesResponse, ErrorType> {
            return .failure(.urlError)
        }
    }
}

//MARK: - Presenter spy -
extension CryptoDetailsInteractorTests{
    class CryptoDetailsPresenterSpy: CryptoDetailsPresentationLogic {
        func presentCryptoDailyPrices(response: CryptoDetailsModel.LoadCryptoList.Response) {
            switch response {
            case .cryptoPrices(let result):
                switch result {
                case .success(let response):
                    self.cryptoResponse = response.response
                case .failure(let error):
                    self.err = error
                }
            }
        }
        
        var cryptoResponse: [String : CryptoDailyPriceResponse] = [:]
        var err: ErrorType = .urlError
        var presentCryptoListCalled = false
        
    }
}
