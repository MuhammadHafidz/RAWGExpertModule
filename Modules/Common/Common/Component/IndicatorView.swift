//
//  IndicatorView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI

public struct IndicatorView: View {
    public init(scaleSize: CGFloat = 1.0, tintColor: Color = .black) {
        self.tintColor = tintColor
        self.scaleSize = scaleSize
    }
    var tintColor: Color
    var scaleSize: CGFloat
    public var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}
