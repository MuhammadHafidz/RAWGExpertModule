//
//  GameEntity.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var releaseDate: String = ""
    @Persisted var imageBackground: String?
    @Persisted var rating: Double?
    
}
