//
//  GameViewCell.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import SwiftUI
import RealmSwift

struct GameViewCell: View {
    internal let game: Game
    @State private var isInfoButtonTapped: Bool = false
    
    init(game: Game) {
        self.game = game
    }
    
    init(gameDetail: GameDetail) {
        let game = Game()
        game.id = gameDetail.id
        game.title = gameDetail.title
        game.thumbnail = gameDetail.thumbnail
        game.short_description = gameDetail.short_description
        game.game_url = gameDetail.game_url
        game.genre = gameDetail.genre
        game.platform = gameDetail.platform
        game.publisher = gameDetail.publisher
        game.developer = gameDetail.developer
        game.release_date = gameDetail.release_date
        game.freetogame_profile_url = gameDetail.freetogame_profile_url
        game.isFavourite = gameDetail.isFavourite
        
        self.game = game
    }
    
    var body: some View {
        VStack {
            Spacer()
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.1)
                    .frame(width: 350, height: 200)
            }
            
            Text(game.title)
                .font(.system(size: 32))
                .foregroundColor(Color.blue)
            
            Spacer()
            
            Text(game.short_description)
                .font(.system(size: 24))
            
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        Text("Género: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(game.genre)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Plataforma: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(game.platform)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Editor: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(game.publisher)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Fecha de lanzamiento: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(DateUtil.formatDate(game.release_date))
                            .font(.system(size: 16))
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isInfoButtonTapped = true
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $isInfoButtonTapped) {
                    if let isFavourite =  game.isFavourite {
                        GameDetailView(id: game.id, isFavourite: isFavourite)
                    } else {
                        GameDetailView(id: game.id, isFavourite: false)
                    }
                }
            }
//            Spacer()
//            Image(systemName: (juego.isFavourite ?? false) ? "heart.fill" : "heart")
        }
        .lineSpacing(8.0)
    }
}
