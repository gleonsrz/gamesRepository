//
//  GameViewModel.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import Combine
import SwiftUI
import RealmSwift

class GameViewModel: ObservableObject {
    private let url = "https://www.freetogame.com/api/games"
    private var task: AnyCancellable?
    @Published var games: [Game] = []
    
    func obtenerJuegos() {
        task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { $0.data }
            .decode(type: [Game].self, decoder: JSONDecoder())
            .handleEvents(receiveSubscription: { _ in
                print("Iniciando la suscripción para obtener juegos")
            }, receiveOutput: { juegos in
                print("Datos recibidos con éxito:", juegos)
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Decodificación completada exitosamente.")
                case .failure(let error):
                    print("Error al decodificar datos:", error)
                }
            }, receiveCancel: {
                print("La suscripción para obtener juegos ha sido cancelada.")
            })
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \GameViewModel.games, on: self)
    }
}
