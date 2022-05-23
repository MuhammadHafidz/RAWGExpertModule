//
//  DetailMapper.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import Core
import GameDomain

public struct DetailMapper: Mapper {
    public typealias Response = GameDetailResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameDetailModel
    
    public init() {
    }
    
    public func transformResponseToEntity(response: GameDetailResponse) -> GameEntity {
        fatalError()
    }
    
    public func transformResponseToDomain(response: GameDetailResponse) -> GameDetailModel {
        return GameDetailModel(
            id: response.id,
            name: response.name,
            releaseDate: response.releaseDate,
            rating: response.rating,
            imageBackground: response.imageBackground ?? "",
            image: response.image ?? "",
            metacritic: response.metacritic != nil ? String(response.metacritic!) : "-",
            playtime: response.playtime != nil ? String(response.playtime!) : "-",
            esrbRating: response.esrbRating ?? "",
            platforms: response.platforms ?? "",
            genres: response.genres ?? "",
            developers: response.developers ?? "",
            publishers: response.publishers ?? "",
            description: response.description ?? "",
            urlWeb: response.urlWeb ?? ""
        )
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameDetailModel {
        fatalError()
    }
    
    public func transformDomainToEntiry(domain: GameDetailModel) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = domain.id
        newGame.name = domain.name
        newGame.releaseDate = domain.releaseDate
        newGame.rating = domain.rating ?? 0.0
        newGame.imageBackground = domain.imageBackground ?? ""
        return newGame
    }
}
