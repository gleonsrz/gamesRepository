//
//  Model.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import Foundation
import RealmSwift

class Game: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var short_description: String
    @Persisted var game_url: String
    @Persisted var genre: String
    @Persisted var platform: String
    @Persisted var publisher: String
    @Persisted var developer: String
    @Persisted var release_date: String
    @Persisted var freetogame_profile_url: String
    @Persisted var isFavourite: Bool? = false
    
    override class func primaryKey() -> String? {
        "id"
    }
}
