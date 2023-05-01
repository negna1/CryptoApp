//
//  TabViewFrameModifier.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import SwiftUI

struct TabViewFrameModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

extension View {
    func tabViewModifier() -> some View {
            modifier(TabViewFrameModifier())
    }
}
