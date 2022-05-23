//
//  GameRow.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import GameDomain
import SDWebImageSwiftUI

public struct GameRow: View {
    
    public init(game: GameModel) {
        self.game = game
    }
    
    var game: GameModel
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(game.name)
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(game.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.bottom, 20.0)
                }
                .padding(.leading, 20.0)
                Spacer()
            }
            HStack {
                if let rating = game.rating {
                    StarsView(rating: rating)
                }
            }
            .padding([.top, .trailing], 20.0)
        }
        .frame(height: 150)
        .background(
            Color.white
                .overlay(
                    WebImage(url: URL(string: game.imageBackground ?? "" ))
                        .resizable()
                        .placeholder {
                            Color.gray.opacity(0.1)
                                .cornerRadius(25)
                                .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        }
                        .indicator(.activity)
                        .scaledToFill()
                        .overlay(TintOverlay().opacity(0.75))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                )
                .clipped()
                .cornerRadius(20)
        )
    }
}
