//
//  ContentView.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import SwiftUI
import RealmSwift

struct GameView: View {
    @ObservedObject private var networkManager = NetworkManager.shared
    @ObservedObject var viewModel = GameViewModel()
    @ObservedResults(GameDetail.self) var favourites
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    if networkManager.isReachable {
                        if favourites.count > 0 {
                            Section {
                                ForEach(favourites) { favourite in
                                    GameViewCell(gameDetail: favourite)
                                        .listRowBackground(Color.clear)
                                }.onDelete(perform: $favourites.remove)
                                
                            } header: {
                                Text("Tus favoritos")
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                        } else {
                            Text("Todavía no tienes favoritos")
                        }
                        Section {
                            ForEach(viewModel.games) { game in
                                GameViewCell(game: game)
                                    .listRowBackground(Color.clear)
                            }
                        } header: {
                            Text("Todos los juegos")
                        }
                        .headerProminence(.increased)
                    } else {
                        if favourites.count > 0 {
                            Section { 
                                ForEach(favourites) { favourite in
                                    GameViewCell(gameDetail: favourite)
                                        .listRowBackground(Color.clear)
                                }.onDelete(perform: $favourites.remove)
                                
                            } header: {
                                Text("Tus favoritos")
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                        } else {
                            Text("Ups, parece que no estás conectado a internet y no tienes favoritos")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .accentColor(nil)
                .onAppear {
                    self.viewModel.obtenerJuegos()
                }
                .padding()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
