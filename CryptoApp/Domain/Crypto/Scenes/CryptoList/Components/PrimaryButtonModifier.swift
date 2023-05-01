//
//  PrimaryButtonModifier.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var backgroundColor: Color
    var titleColor: Color
    var needClickedAnimation: Bool
    func body(content: Content) -> some View {
            content
            .font(.body)
                .foregroundColor(.white)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 2)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .buttonStyle(needClickedAnimation ? ShadowButtonStyle() : .init())
        
    }
}

extension View {
    func primaryButton(
        isFlexible: Bool = true,
        backgroundColor: Color = .black,
        titleColor: Color = .white) -> some View {
            modifier(PrimaryButtonModifier(
                backgroundColor: backgroundColor,
                titleColor: titleColor,
                needClickedAnimation: true))
        }
}

struct ShadowButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .shadow(
        color: configuration.isPressed ? Color.red : Color.black,
        radius: 2, x: 0, y: 5
      )
  }
}
