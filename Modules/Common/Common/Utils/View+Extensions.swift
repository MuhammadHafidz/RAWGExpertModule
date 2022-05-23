//
//  View+Extensions.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder func hidden(_ hide: Bool) -> some View {
        switch hide {
        case true : self.hidden()
        case false : self
        }
    }
}

public struct TintOverlay: View {
    public var body: some View {
        ZStack {
            Text(" ")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: Color.gradient), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .cornerRadius(25)
    }
}

public extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}
