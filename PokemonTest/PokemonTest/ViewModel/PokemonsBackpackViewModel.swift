//
//  PokemonsBackpackViewModel.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import Foundation
import SwiftUI

class PokemonsBackpackViewModel: ObservableObject {
    
    @Published var savedPokemonsList: [Pokemon]?
    
    /// Error recieved from Network call
    @Published var serviceError: JsonError?
    
    /// Network Manager instance for handling network calls
    var databaseManager = DatabaseManager()
    
    /// To fetch data saved in Database.
    func fetchSavedPokemons(completion: ((Bool) -> Void)? = nil) {
        
        databaseManager.fetchPokemons(from: "PokemonData") { [weak self]  (pokemonList, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self?.savedPokemonsList = pokemonList
                    completion?(true)
                } else {
                    self?.serviceError = error
                    completion?(false)
                }
            }
        }
    }
}
