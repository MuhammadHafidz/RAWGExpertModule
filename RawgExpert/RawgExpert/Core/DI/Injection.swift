//
//  Injection.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift
import Swinject
import Core
import GameDomain
import GameRepository

final class Injection: NSObject {
    let container: Container = Container()
    
    override init() {
        let realm = try? Realm()
        
        container.register(RepositoryGetGames<GetGames, GamesMapper>.self) { _ in
            return RepositoryGetGames(
                remoteDataSource: GetGames(),
                mapper: GamesMapper()
            )
        }
        
        container.register(RepositoryGetSearchGame<GetSearchGame, GamesMapper>.self) { _ in
            return RepositoryGetSearchGame(
                remoteDataSource: GetSearchGame(),
                mapper: GamesMapper()
            )
        }
        
        container.register(RepositoryGetDetailGame<GetDetailGame, DetailMapper>.self) { _ in
            return RepositoryGetDetailGame(
                remoteDataSource: GetDetailGame(),
                mapper: DetailMapper()
            )
        }
        
        container.register(FavoriteDataSource.self) { _ in
            return FavoriteDataSource(realm: realm)
        }
        
        container.register(RepositoryGetFavorites<FavoriteDataSource, GamesMapper>.self) { resolver in
            return RepositoryGetFavorites(
                localSource: resolver.resolve(FavoriteDataSource.self)!,
                mapper: GamesMapper()
            )
        }
        
        container.register(RepositoryGetFavorite<FavoriteDataSource, GameMapper>.self) { resolver in
            return RepositoryGetFavorite(
                localSource: resolver.resolve(FavoriteDataSource.self)!,
                mapper: GameMapper()
            )
        }
        
        container.register(RepositoryAddFavorite<FavoriteDataSource, DetailMapper>.self) { resolver in
            return RepositoryAddFavorite(
                localSource: resolver.resolve(FavoriteDataSource.self)!,
                mapper: DetailMapper()
            )
        }
        
        container.register(RepositoryDeleteFavorite<FavoriteDataSource>.self) { resolver in
            return RepositoryDeleteFavorite(localSource: resolver.resolve(FavoriteDataSource.self)!)
        }
        
    }
    
    func provideGetGames<U: UseCase>() -> U
    where
    U.Request == Any,
    U.Response == [GameModel] {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryGetGames<
                                                         GetGames,
                                                         GamesMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideGetSearchGames<U: UseCase>() -> U
    where
    U.Request == String,
    U.Response == [GameModel] {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryGetSearchGame<
                                                         GetSearchGame,
                                                         GamesMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideGetDetailGame<U: UseCase>() -> U
    where
    U.Request == String,
    U.Response == GameDetailModel {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryGetDetailGame<
                                                         GetDetailGame,
                                                         DetailMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideGetFavGames<U: UseCase>() -> U
    where
    U.Request == Any,
    U.Response == [GameModel] {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryGetFavorites<
                                                         FavoriteDataSource,
                                                         GamesMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideGetFavGame<U: UseCase>() -> U
    where
    U.Request == String,
    U.Response == GameModel? {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryGetFavorite<
                                                         FavoriteDataSource,
                                                         GameMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideAddFavGame<U: UseCase>() -> U
    where
    U.Request == GameDetailModel,
    U.Response == Bool {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryAddFavorite<
                                                         FavoriteDataSource,
                                                         DetailMapper
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
    func provideDelFavGame<U: UseCase>() -> U
    where
    U.Request == Int,
    U.Response == Bool {
        guard let interactor =
                Interactor(repository: container.resolve(RepositoryDeleteFavorite<
                                                         FavoriteDataSource
                                                         >.self)!) as? U else {
            fatalError()
        }
        return interactor
    }
    
}
