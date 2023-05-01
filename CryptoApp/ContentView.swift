//
//  ContentView.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 27.04.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CryptoListView().configureView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
