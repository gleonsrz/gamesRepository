//
//  ContentView.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
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
                                    GameView(detalleJuego: favourite)
                                        .listRowBackground(Color.clear)
                                }.onDelete(perform: $favourites.remove)
                                
                            } header: {
                                Text("Tus favoritos")
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                        }
                        Section {
                            ForEach(viewModel.juegos) { juego in
                                GameView(juego: juego)
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
                                    GameView(detalleJuego: favourite)
                                        .listRowBackground(Color.clear)
                                }.onDelete(perform: $favourites.remove)
                                
                            } header: {
                                Text("Tus favoritos")
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
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
        ContentView()
    }
}
