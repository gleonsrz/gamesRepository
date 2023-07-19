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
    
    override init() {
    }
    
    convenience init(id: Int,
                     title: String,
                     thumbnail: String,
                     short_description: String,
                     game_url: String,
                     genre: String,
                     platform: String,
                     publisher: String,
                     developer: String,
                     release_date: String,
                     freetogame_profile_url: String,
                     isFavourite: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.short_description = short_description
        self.game_url = game_url
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.release_date = release_date
        self.freetogame_profile_url = freetogame_profile_url
        self.isFavourite = isFavourite
    }
}
