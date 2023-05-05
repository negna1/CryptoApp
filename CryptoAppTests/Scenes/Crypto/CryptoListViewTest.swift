//
//  CryptoListViewTest.swift
//  CryptoAppTests
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import XCTest
@testable import CryptoApp

class CreateCryptoListViewTests: XCTestCase {
    var sut: CryptoListView!
    var interactorSpy: CryptoListInteractorSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptoListView()
        interactorSpy = CryptoListInteractorSpy()
    }
    
    // MARK: - Test doubles
    class CryptoListInteractorSpy: CryptoListBusinessLogic {
        var loadCalled = false
        func loadCrypto(request: CryptoApp.CryptoList.LoadCryptoList.Request) {
            loadCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldMakeLoading() {
        sut.interactor = interactorSpy
        XCTAssertTrue(
            !interactorSpy.loadCalled,
            "Loading state"
        )
    }
    
    func testShouldLoadSuccess() {
        sut.interactor = interactorSpy
        sut.viewAppear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertTrue(
                self.interactorSpy.loadCalled,
                "Success"
            )
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }
}
