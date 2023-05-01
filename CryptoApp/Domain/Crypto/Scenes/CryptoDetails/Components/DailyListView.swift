//
//  DailyListView.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import SwiftUI

struct DailyListView: View {
    var details: [CryptoDailyPrice]
    var body: some View {
        ScrollView {
            ForEach(details) {daily in
                VStack {
                    HorizontalTitles(keyString: Constant.time, valueString: daily.time)
                    HorizontalTitles(keyString: Constant.price, valueString: daily.price.description)
                    Divider()
                }
            }
        }
    }
    
    struct HorizontalTitles: View {
        let keyString: String
        let valueString: String
        var body: some View {
            HStack {
                Text(keyString)
                    .font(.title3)
                Text(valueString)
                    .font(.caption)
                    .padding(.leading)
                Spacer()
            }
        }
    }
}
