//
//  CryptoDetails.Configurator.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI

extension CryptoDetailsView {
    func configureView(cryptos: [CryptoDetails], currentCrypto: CryptoDetails) -> some View {
        var view = self
        view.store = .init(cryptos: cryptos, currentCrypto: currentCrypto)
        let interactor = CryptoDetailsInteractor()
        let worker = CryptoDetailsDisplay()
        let presenter = CryptoDetailsPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.view = view

        return view
    }
}
