//
//  GameMapper.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import Core
import GameDomain

public struct GamesMapper: Mapper {
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameModel]
    
    public init() {
    }
    
    public func transformResponseToEntity(response: [GameResponse]) -> [GameEntity] {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
        return entity.map { data in
            return GameModel(
                id: data.id,
                name: data.name,
                rating: data.rating!,
                released: data.releaseDate,
                background_image: data.imageBackground
            )
        }
    }
    
    public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
        return response.map { data in
            return GameModel(
                id: data.id,
                name: data.name,
                rating: data.rating!,
                released: data.releaseDate,
                background_image: data.imageBackground ?? ""
            )
        }
    }
    
    public func transformDomainToEntiry(domain: [GameModel]) -> [GameEntity] {
        fatalError()
    }
    
}
