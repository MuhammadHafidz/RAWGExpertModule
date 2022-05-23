//
//  GameModel.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    public init(id: Int, name: String, rating: Double, released: String?, background_image: String?) {
        self.id = id
        self.name = name
        self.rating = rating
        self.releaseDate = released!
        self.imageBackground = background_image
    }
    
    public var id: Int
    public var name: String
    public var releaseDate: String
    public var rating: Double?
    public var imageBackground: String?
}
