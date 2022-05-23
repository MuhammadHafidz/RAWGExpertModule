//
//  GameRepository.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import Core
import RealmSwift
import RxSwift
import GameDomain

public struct RepositoryGetGames<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository
where
RemoteDataSource.Request == Any,
RemoteDataSource.Response == [GameResponse],
Transformer.Response == [GameResponse],
Transformer.Domain == [GameModel] {
    public typealias Request = Any
    public typealias Response = [GameModel]
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> Observable<[GameModel]> {
        return self._remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(response: $0) }
    }
}

public struct RepositoryGetSearchGame<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository
where
RemoteDataSource.Request == String,
RemoteDataSource.Response == [GameResponse],
Transformer.Response == [GameResponse],
Transformer.Domain == [GameModel] {
    public typealias Request = String
    public typealias Response = [GameModel]
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<[GameModel]> {
        return self._remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(response: $0) }
    }
}

public struct RepositoryGetDetailGame<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository
where
RemoteDataSource.Request == String,
RemoteDataSource.Response == GameDetailResponse,
Transformer.Response == GameDetailResponse,
Transformer.Domain == GameDetailModel {
    public typealias Request = String
    public typealias Response = GameDetailModel
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<GameDetailModel> {
        return self._remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(response: $0) }
    }
}

public struct RepositoryGetFavorites<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
GameLocaleDataSource.Request == Any,
GameLocaleDataSource.Response == GameEntity,
Transformer.Entity == [GameEntity],
Transformer.Domain == [GameModel] {
    public typealias Request = Any
    public typealias Response = [GameModel]
    private let _localSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localSource: GameLocaleDataSource,
        mapper: Transformer
    ) {
        _localSource = localSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> Observable<[GameModel]> {
        return self._localSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0)}
    }
}

public struct RepositoryGetFavorite<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
GameLocaleDataSource.Request == Any,
GameLocaleDataSource.Response == GameEntity,
Transformer.Entity == GameEntity,
Transformer.Domain == GameModel {
    public typealias Request = String
    public typealias Response = GameModel?
    private let _localSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localSource: GameLocaleDataSource,
        mapper: Transformer
    ) {
        _localSource = localSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<GameModel?> {
        return self._localSource.get(id: request!)
            .map { _mapper.transformEntityToDomain(entity: $0)}
    }
}

public struct RepositoryAddFavorite<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
GameLocaleDataSource.Request == Any,
GameLocaleDataSource.Response == GameEntity,
Transformer.Entity == GameEntity,
Transformer.Domain == GameDetailModel {
    public typealias Request = GameDetailModel
    public typealias Response = Bool
    private let _localSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localSource: GameLocaleDataSource,
        mapper: Transformer
    ) {
        _localSource = localSource
        _mapper = mapper
    }
    
    public func execute(request: GameDetailModel?) -> Observable<Bool> {
        return self._localSource.add(entities: _mapper.transformDomainToEntiry(domain: request!))
    }
}

public struct RepositoryDeleteFavorite<
    GameLocaleDataSource: LocaleDataSource
>: Repository
where
GameLocaleDataSource.Request == Any,
GameLocaleDataSource.Response == GameEntity {
    
    public typealias Request = Int
    public typealias Response = Bool
    
    private let _localSource: GameLocaleDataSource
    
    public init(
        localSource: GameLocaleDataSource
    ) {
        _localSource = localSource
    }
    
    public func execute(request: Int?) -> Observable<Bool> {
        return self._localSource.delete(id: request!)
    }
}
    
