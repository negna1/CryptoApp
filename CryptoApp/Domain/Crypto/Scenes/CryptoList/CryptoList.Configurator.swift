//
//  CryptoList.Configurator.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI

extension CryptoListView {
  func configureView() -> some View {
    var view = self
    let interactor = CryptoListInteractor()
    let worker = CryptoListDisplay()
    let presenter = CryptoListPresenter()
    view.interactor = interactor
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.view = view

    return view
  }
}

