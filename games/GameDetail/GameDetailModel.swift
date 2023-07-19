//
//  GameDetailModel.swift
//  games
//
//  Created by Christian Leon on 18/07/23.
//
import RealmSwift
import Foundation

class GameDetail: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var status: String
    @Persisted var short_description: String
    @Persisted var gameDescriptionText: String
    @Persisted var game_url: String
    @Persisted var genre: String
    @Persisted var platform: String
    @Persisted var publisher: String
    @Persisted var developer: String
    @Persisted var release_date: String
    @Persisted var freetogame_profile_url: String
    @Persisted var minimum_system_requirements: SystemRequirements?
    @Persisted var screenshots: List<Screenshot>
    @Persisted var isFavourite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case status
        case short_description
        case game_url
        case genre
        case platform
        case publisher
        case developer
        case release_date
        case freetogame_profile_url
        case gameDescriptionText = "description"
        case minimum_system_requirements
        case screenshots
        case isFavourite
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        status = try container.decode(String.self, forKey: .status)
        short_description = try container.decode(String.self, forKey: .short_description)
        gameDescriptionText = try container.decode(String.self, forKey: .gameDescriptionText)
        game_url = try container.decode(String.self, forKey: .game_url)
        genre = try container.decode(String.self, forKey: .genre)
        platform = try container.decode(String.self, forKey: .platform)
        publisher = try container.decode(String.self, forKey: .publisher)
        developer = try container.decode(String.self, forKey: .developer)
        release_date = try container.decode(String.self, forKey: .release_date)
        freetogame_profile_url = try container.decode(String.self, forKey: .freetogame_profile_url)
        minimum_system_requirements = try container.decodeIfPresent(SystemRequirements.self, forKey: .minimum_system_requirements)
        screenshots.append(objectsIn: (try container.decodeIfPresent([Screenshot].self, forKey: .screenshots) ?? []))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(status, forKey: .status)
        try container.encode(short_description, forKey: .short_description)
        try container.encode(game_url, forKey: .game_url)
        try container.encode(genre, forKey: .genre)
        try container.encode(platform, forKey: .platform)
        try container.encode(publisher, forKey: .publisher)
        try container.encode(developer, forKey: .developer)
        try container.encode(release_date, forKey: .release_date)
        try container.encode(freetogame_profile_url, forKey: .freetogame_profile_url)
        try container.encode(minimum_system_requirements, forKey: .minimum_system_requirements)
        try container.encode(Array(screenshots), forKey: .screenshots)
    }
}


class SystemRequirements: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: UUID? = UUID()
    @Persisted var os: String?
    @Persisted var processor: String?
    @Persisted var memory: String?
    @Persisted var graphics: String?
    @Persisted var storage: String?
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class Screenshot: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var image: String?
    
    override class func primaryKey() -> String? {
        "id"
    }
}

struct IdentifiableURL: Identifiable {
    var id = UUID()
    var url: URL
}
