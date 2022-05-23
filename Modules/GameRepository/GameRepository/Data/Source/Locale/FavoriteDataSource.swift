//
//  LocaleDataSource.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import RealmSwift
import Core
import RxSwift

public struct FavoriteDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = GameEntity
    
    private let _realm: Realm?
    
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func list(request: Any?) -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
            if let realm = self._realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                observer.onNext(games.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func add(entities: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        realm.add(entities, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func get(id: String) -> Observable<GameEntity> {
        return Observable<GameEntity>.create { observer in
            if let realm = self._realm {
                if let object = realm.objects(GameEntity.self).filter("id = \(id)").first {
                    observer.onNext(object)
                    observer.onCompleted()
                } else {
                    observer.onCompleted()
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func update(id: Int, entity: GameEntity) -> Observable<Bool> {
        fatalError()
    }
    
    public func delete(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                if let object = realm.objects(GameEntity.self).filter("id = \(id)").first {
                    do {
                        try realm.write {
                            realm.delete(object)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}
