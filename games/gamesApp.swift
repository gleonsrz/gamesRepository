//
//  gamesApp.swift
//  games
//
//  Created by Christian Leon on 17/07/23.
//

import SwiftUI

@main
struct gamesApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
