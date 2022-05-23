//
//  GameMapper.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import Core
import GameDomain

public struct GameMapper: Mapper {
    public typealias Response = GameResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameModel
    
    public init() {
    }
    
    public func transformResponseToEntity(response: GameResponse) -> GameEntity {
        fatalError()
    }
    
    public func transformResponseToDomain(response: GameResponse) -> GameModel {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameModel {
        return GameModel(
            id: entity.id,
            name: entity.name,
            rating: entity.rating!,
            released: entity.releaseDate,
            background_image: entity.imageBackground
        )

    }
    
    public func transformDomainToEntiry(domain: GameModel) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = domain.id
        newGame.name = domain.name
        newGame.releaseDate = domain.releaseDate
        newGame.rating = domain.rating ?? 0.0
        newGame.imageBackground = domain.imageBackground ?? ""
        return newGame
    }
}
