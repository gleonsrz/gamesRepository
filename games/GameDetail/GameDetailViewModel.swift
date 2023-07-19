//
//  GameDetailViewModel.swift
//  games
//
//  Created by Christian Leon on 18/07/23.
//

import Combine
import SwiftUI

class GameDetailViewModel: ObservableObject {
    private let url = "https://www.freetogame.com/api/game?id="
    private var task: AnyCancellable?
    
    @Published var detalleJuego: GameDetail = GameDetail()
    
    func obtenerDetalleJuego(id: Int) {
        let completeUrl = url + "\(id)"
        task = URLSession.shared.dataTaskPublisher(for: URL(string: completeUrl)!)
            .map { $0.data }
            .decode(type: GameDetail.self, decoder: JSONDecoder())
            .handleEvents(receiveSubscription: { _ in
                print("Iniciando la suscripción para obtener el detalle del juego")
            }, receiveOutput: { detalleJuego in
                print("Datos recibidos con éxito:", detalleJuego)
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Decodificación completada exitosamente.")
                case .failure(let error):
                    print("Error al decodificar datos:", error)
                }
            }, receiveCancel: {
                print("La suscripción para obtener el detalle del juego ha sido cancelada.")
            })
            .replaceError(with: GameDetail())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \GameDetailViewModel.detalleJuego, on: self)
    }
}
