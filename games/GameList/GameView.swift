//
//  GameView.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import SwiftUI
import RealmSwift

struct GameView: View {
    internal let juego: Game
    @State private var isInfoButtonTapped: Bool = false
    
    init(juego: Game) {
        self.juego = juego
    }
    
    init(detalleJuego: GameDetail) {
        let juego = Game()
        juego.id = detalleJuego.id
        juego.title = detalleJuego.title
        juego.thumbnail = detalleJuego.thumbnail
        juego.short_description = detalleJuego.short_description
        juego.game_url = detalleJuego.game_url
        juego.genre = detalleJuego.genre
        juego.platform = detalleJuego.platform
        juego.publisher = detalleJuego.publisher
        juego.developer = detalleJuego.developer
        juego.release_date = detalleJuego.release_date
        juego.freetogame_profile_url = detalleJuego.freetogame_profile_url
        juego.isFavourite = detalleJuego.isFavourite
        
        self.juego = juego
    }
    
    var body: some View {
        VStack {
            Spacer()
            AsyncImage(url: URL(string: juego.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.1)
                    .frame(width: 350, height: 200)
            }
            
            Text(juego.title)
                .font(.system(size: 32))
                .foregroundColor(Color.blue)
            
            Spacer()
            
            Text(juego.short_description)
                .font(.system(size: 24))
            
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        Text("Género: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(juego.genre)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Plataforma: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(juego.platform)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Editor: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(juego.publisher)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Fecha de lanzamiento: ")
                            .font(.system(size: 16))
                            .foregroundColor(Color.blue)
                        Text(DateUtil.formatDate(juego.release_date))
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
                    if let isFavourite =  juego.isFavourite {
                        GameDetailView(id: juego.id, isFavourite: isFavourite)
                    } else {
                        GameDetailView(id: juego.id, isFavourite: false)
                    }
                }
            }
//            Spacer()
//            Image(systemName: (juego.isFavourite ?? false) ? "heart.fill" : "heart")
        }
        .lineSpacing(8.0)
    }
}
