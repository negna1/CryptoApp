//
//  CryptoListInteractorTests.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import Foundation

import XCTest
import NetworkLayer
@testable import CryptoApp

class CryptoInteractorTests: XCTestCase {
    var sut: CryptoListInteractor!
    var presenterSpy: CryptoListPresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoListInteractor()
        sut.worker = workerSpy()
        presenterSpy = CryptoListPresenterSpy()
    }
    
    // MARK: - Tests
    func testSuccessCall() async {
        sut.presenter = presenterSpy
        let cryptoList: [CryptoResponse] = [.sample]
        let request = CryptoList.LoadCryptoList.Request.cryptoList
        let expectation = self.expectation(description: "Waiting for the retrieveAlumni call to complete.")
        sut.loadCrypto(request: request)
        expectation.fulfill()
        
        await waitForExpectations(timeout: 4) { error in
            XCTAssertNil(error)
            XCTAssertEqual(
                self.presenterSpy.cryptoResponse,
                cryptoList,
                "Success error"
            )
        }
    }
    
    func testErrorCall() async {
        sut.worker = ErrorWorkerSpy()
        sut.presenter = presenterSpy
        let request = CryptoList.LoadCryptoList.Request.cryptoList
        let expectation = self.expectation(description: "Waiting for the get crypto  call to complete.")
        sut.loadCrypto(request: request)
        expectation.fulfill()
        
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
extension CryptoInteractorTests {
    class workerSpy: CryptoListDisplayWorker {
        func fetcCryptoList() async -> Result<CryptoResponseData, ErrorType> {
            return .success(.sample)
        }
        
        func fetcCryptoPrices() async -> Result<CryptoPricesResponse, ErrorType> {
            return .success(.sample)
        }
    }
    
    class ErrorWorkerSpy: CryptoListDisplayWorker {
        func fetcCryptoList() async -> Result<CryptoResponseData, ErrorType> {
            return .failure(.urlError)
        }
        
        func fetcCryptoPrices() async -> Result<CryptoPricesResponse, ErrorType> {
            return .failure(.urlError)
        }
    }
}

//MARK: - Presenter spy -
extension CryptoInteractorTests{
    class CryptoListPresenterSpy: CryptoListPresentationLogic {
        func presentCryptoList(response: CryptoList.LoadCryptoList.Response) {
            presentCryptoListCalled = true
            switch response {
            case .cryptoResponse(let result):
                switch result {
                case .success(let response):
                    self.cryptoResponse = response.response ?? []
                case .failure(let error):
                    self.err = error
                }
            case .cryptoPrices(let result):
                switch result {
                case .success(let response):
                    self.cryptoPricesResponse = response.response ?? []
                case .failure(let error):
                    self.err = error
                }
            }
        }
        
        var cryptoResponse: [CryptoResponse] = []
        var cryptoPricesResponse: [CryptoPriceResponse] = []
        var err: ErrorType = .urlError
        var presentCryptoListCalled = false
        
    }
}
