//
//  PokemonDetailsViewModel.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import Foundation

class PokemonDetailsViewModel: ObservableObject {
    
    /// Pokemon Data
    var currentPokemon: Pokemon?
    
    /// Network Manager instance for handling network calls
    var databaseManager = DatabaseManager()
    
    /**
     To save data into database
    
     - returns: Model Object
     */
    func savePokemon(completion: fetchDataCompletionHandler?) {
        if let pokemon = currentPokemon {
            pokemon.isCollected = true
            pokemon.dateTimeWhenCollected = PokemonDetailsViewModel.getCurrentDateTime()
            databaseManager.savePokemon(object: pokemon, for: "PokemonData", with: completion)
        }
    }
    
    /// To get current date time in string: To be used as timestamp.
    class func getCurrentDateTime() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }
}
