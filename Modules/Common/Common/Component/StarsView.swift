//
//  StarsView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//
import SwiftUI

public struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int = 5
    
    public init(rating: CGFloat, maxRating: Int = 5) {
        self.rating = rating
        self.maxRating = maxRating
    }

    public var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating) { _ in
                Image(systemName: "star.fill")
            }
        }

        stars.overlay(
            GeometryReader { geometry in
                let width = rating / CGFloat(maxRating) * geometry.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
                .mask(stars)
        )
        .foregroundColor(.gray)
    }
}
