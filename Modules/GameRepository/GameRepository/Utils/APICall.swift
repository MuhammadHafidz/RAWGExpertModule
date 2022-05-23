//
//  APICall.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
    static func apiKey() -> String {
        let bundle = Bundle(identifier: "id.haff.GameRepository")
        guard let filePath = bundle!.path(forResource: "Keys", ofType: "plist") else {
          fatalError("Couldn't find file 'Keys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "api_key") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Keys.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Key Error")
        }
        return value
    }
}

protocol EndPoint {
    var url: String { get }
}

enum EndPoints {
    enum Gets: EndPoint {
        case games
        case detail(id: String)
        case search
        
        public var url: String {
            switch self {
            case .games: return "\(API.baseUrl)games"
            case .detail(let id): return "\(API.baseUrl)games/\(id)"
            case .search: return "\(API.baseUrl)games"
            }
        }
    }
}
