//
//  NetworkManager.swift
//  games
//
//  Created by Christian Leon on 19/07/23.
//

import Network
import SwiftUI

final class NetworkManager: ObservableObject {
    static let shared = NetworkManager()

    @Published var isReachable: Bool = true

    private let monitor: NWPathMonitor

    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isReachable = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
