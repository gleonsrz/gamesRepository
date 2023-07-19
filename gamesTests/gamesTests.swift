//
//  gamesTests.swift
//  gamesTests
//
//  Created by Christian Leon on 17/07/23.
//

import XCTest
import RealmSwift
import SwiftUI
@testable import games

final class gamesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGameDecoding() throws {
        let json = """
            {
                "id": 1,
                "title": "Test Game",
                "thumbnail": "https://example.com/image.png",
                "short_description": "Test description",
                "game_url": "https://example.com/game",
                "genre": "Test Genre",
                "platform": "Test Platform",
                "publisher": "Test Publisher",
                "developer": "Test Developer",
                "release_date": "2023-01-01",
                "freetogame_profile_url": "https://example.com/profile",
                "isFavourite": true
            }
            """.data(using: .utf8)!
        
        let game = try JSONDecoder().decode(Game.self, from: json)
        
        XCTAssertEqual(game.id, 1)
        XCTAssertEqual(game.title, "Test Game")
        XCTAssertEqual(game.thumbnail, "https://example.com/image.png")
        XCTAssertEqual(game.short_description, "Test description")
        XCTAssertEqual(game.game_url, "https://example.com/game")
        XCTAssertEqual(game.genre, "Test Genre")
        XCTAssertEqual(game.platform, "Test Platform")
        XCTAssertEqual(game.publisher, "Test Publisher")
        XCTAssertEqual(game.developer, "Test Developer")
        XCTAssertEqual(game.release_date, "2023-01-01")
        XCTAssertEqual(game.freetogame_profile_url, "https://example.com/profile")
        XCTAssertEqual(game.isFavourite, true)
    }
    
    func testGameViewRendering() {
        let game = Game(id: 1,
                        title: "Test Game",
                        thumbnail: "https://example.com/image.png",
                        short_description: "Test description",
                        game_url: "https://example.com/game",
                        genre: "Action",
                        platform: "PC",
                        publisher: "Publisher A",
                        developer: "Developer X",
                        release_date: "2023-01-01",
                        freetogame_profile_url: "https://example.com/profile/game1",
                        isFavourite: true)
        
        let view = GameView(juego: game)
        
        XCTAssertEqual(view.juego.title, "Test Game")
        XCTAssertEqual(view.juego.short_description, "Test description")
        XCTAssertEqual(view.juego.genre, "Action")
        XCTAssertEqual(view.juego.platform, "PC")
        XCTAssertEqual(view.juego.publisher, "Publisher A")
        XCTAssertEqual(view.juego.release_date, "2023-01-01")
        
    }
}
