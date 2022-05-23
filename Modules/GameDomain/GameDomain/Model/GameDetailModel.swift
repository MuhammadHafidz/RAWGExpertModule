//
//  GameDetailModel.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation

public struct GameDetailModel: Equatable, Identifiable {
    public init(
        id: Int,
        name: String,
        releaseDate: String,
        rating: Double?,
        imageBackground: String?,
        image: String,
        metacritic: String,
        playtime: String,
        esrbRating: String,
        platforms: String,
        genres: String,
        developers: String,
        publishers: String,
        description: String,
        urlWeb: String
    ) {
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.rating = rating
        self.imageBackground = imageBackground
        self.image = image
        self.metacritic = metacritic
        self.playtime = playtime
        self.esrbRating = esrbRating
        self.platforms = platforms
        self.genres = genres
        self.developers = developers
        self.publishers = publishers
        self.description = description
        self.urlWeb = urlWeb
    }
    
    public let id: Int
    public let name: String
    public let releaseDate: String
    public let rating: Double?
    public let imageBackground: String?
    public let image: String
    public let metacritic: String
    public let playtime: String
    public let esrbRating: String
    public let platforms: String
    public let genres: String
    public let developers: String
    public let publishers: String
    public let description: String
    public let urlWeb: String
    
}
