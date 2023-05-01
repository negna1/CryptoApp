//
//  ActivityIndicator.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 28.04.23.
//

import SwiftUI


struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                                .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}

struct AsyncImageModifier: ViewModifier {
    let urlString: String
    let size: CGFloat
    func body(content: Content) -> some View {
        AsyncImage(url: URL(string: urlString)) {phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
    }
}

extension View {
    func AsyncImageView(urlString: String, size: CGFloat = 40) -> some View {
        return modifier(AsyncImageModifier(urlString: urlString, size: size))
    }
}
