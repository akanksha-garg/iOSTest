//
//  PokemonTestApp.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

@main
struct PokemonTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SearchPokemonView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
