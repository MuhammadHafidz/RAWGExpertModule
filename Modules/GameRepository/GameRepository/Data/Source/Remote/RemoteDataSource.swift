//
//  RemoteDataSource.swift
//  GameRepository
//
//  Created by Enygma System on 21/05/22.
//

import Foundation
import Core
import RxSwift
import Alamofire

public struct GetGames: DataSource {
    public typealias Request = Any
    public typealias Response = [GameResponse]
    
    public init() {
    }
    
    public func execute(request: Any?) -> Observable<[GameResponse]> {
        let parameters = ["key": API.apiKey()]
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.games.url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val.results ?? [])
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}

public struct GetDetailGame: DataSource {
    public typealias Request = String
    public typealias Response = GameDetailResponse
    
    public init() {
    }

    public func execute(request: String?) -> Observable<GameDetailResponse> {
        let parameters = [
            "key": API.apiKey()
        ]
        return Observable<GameDetailResponse>.create { observer in
            if let url = URL(string: EndPoints.Gets.detail(id: request!).url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}

public struct GetSearchGame: DataSource {
    public typealias Request = String
    public typealias Response = [GameResponse]
    
    public init() {
    }
    
    public func execute(request: String?) -> Observable<[GameResponse]> {
        let parameters = [
            "key": API.apiKey(),
            "search": request
        ]
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.search.url) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { res in
                        switch res.result {
                        case .success(let val):
                            observer.onNext(val.results ?? [])
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
