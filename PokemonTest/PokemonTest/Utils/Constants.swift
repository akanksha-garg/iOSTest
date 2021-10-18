//
//  Constants.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

/// Type of identifier for completion of fetch data service call.
typealias fetchDataCompletionHandler = (Bool, JsonError?) -> Void

/// To organize app’s important data and resources, such as colors, images, strings, URLs, etc.
struct Constants {
    
    static let screenWidth = UIScreen.main.bounds.size.width
    
    struct API {
        static let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    }
    
    struct Content {
        static let pokemonDetailsViewTitle = "Pokemon Details"
        static let PokemonsBackpackViewTitle = "Pokemon Backpack"
        static let searchPokemon = "Search Pokemon"
        static let viewBackpack = "View Backpack"
        static let catchButtonTitle = "Catch it (Throw a Pokeball, yes!)"
        static let leaveButtonTitle = "Leave it"
        static let pokemonBackpackNoDataLabel = "Start catching the Pokemons. It will be added to your backpack and will be there forever(yes!)"
        static let ok = "OK"
        static let pokemonAlreadyCaughtMessage = "This Pokemon has been caught on "
        static let pokemonCatchedMessge = "Pokemon catched."
    }
    
    struct Images {
        static let placeholderImage = "Placeholder"
        static let pokemon = "pokemon"
    }
    
    struct Error {
        static let serviceError = "There is some problem in fetching the data."
        static let noDataError = "No Data Found."
        static let notFoundError = "Invalid URL."
        static let inValidJSONError = "Couldn't parse JSON: %@"
        static let errorTitle = "Error!!"
        static let noNetwork = "Internet connection is not available."
    }
}
